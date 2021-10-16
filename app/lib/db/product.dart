part of 'db.dart';

extension ProductLocalStore on CsvDatabse {
  Future<Data?> readProduct(int id) async {
    final db = await CsvDatabse.instance.database;
    try {
      if (db != null) {
        Data? product;
        await db.transaction((txn) async {
          final maps = await txn.query(
            tableProduct,
            columns: ProductDataFields.values,
            where: '${ProductDataFields.id} = ?',
            whereArgs: [id],
          );
          if (maps.isEmpty || maps.first.isEmpty) {
            return null;
          }
          product = Data.fromJson(maps.first);
          List<Photos> photos = [];
          List<Categories> categories = [];
          List<Attributes> attributes = [];
          List<Pivot> pivots = [];
          final photMap = await txn.query(
            tablePhotos,
            where: '${PhotoFields.referenceId} = ?',
            whereArgs: [product?.id],
          );
          // print("db-pro--read---4");

          photos = photMap.map((json) => Photos.fromJson(json)).toList();
          // print("db-pro--read---5");

          final categoryMap = await txn.query(
            tableProductCategories,
            where: '${CategoryFields.productId} = ?',
            whereArgs: [product?.id],
          );
          // print("db-pro--read---6");

          categories =
              categoryMap.map((json) => Categories.fromJson(json)).toList();

          // print("db-pro--read---7");

          final pivotMap = await txn.query(
            tablePivot,
            where: '${PivotFields.productId} = ?',
            whereArgs: [product?.id],
            // groupBy: PivotFields.attributeId,
          );
          // print("db-pro--read---8");

          pivots = pivotMap.map((json) => Pivot.fromJson(json)).toList();
          // print("db-pro--read---9");

          pivots.forEach((piv) async {
            final datas = await txn.query(
              tableAttributes,
              where: '${AttributeFields.id} = ?',
              whereArgs: [piv.attributeId],
            );
            // print("db-pro--read---10");

            Attributes atr =
                datas.map((json) => Attributes.fromJson(json)).first;
            // print("db-pro--read---11");

            atr.pivot = piv;
            // print("db-pro--read---12");

            attributes.add(atr);
            // print("db-pro--read---13");
          });
          product?.photos = photos;
          product?.categories = categories;
          product?.attributes = attributes;
        });
        return product;
      }
    } catch (e) {
      print("error read product detail");
      print(e);
    }
  }

  Future<void> createProduct(Data product) async {
    final db = await CsvDatabse.instance.database;

    try {
      if (db != null) {
        await db.transaction((txn) async {
          // print("db-pro--create---1");
          await txn.insert(
            tableProduct,
            product.toDBJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          // print("db--pro-create---2");

          List<Photos> photos = [];
          if (product.photos != null) {
            photos = product.photos!;
          }

          // print("-----db--pro-create---3");

          List<Categories>? categories = product.categories;
          // print("-----db--pro-create---4");

          Batch batch = txn.batch();
          // print("-----db--pro-create---5");
          photos.forEach((photo) {
            batch.delete(
              tablePhotos,
              where: '${PhotoFields.referenceId} = ?',
              whereArgs: [photo.id],
            );
          });
          // print("-----db--pro-create---5.1");
          photos.forEach((photo) {
            batch.insert(
              tablePhotos,
              photo.toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          });
          // print("-----db--pro-create---6");
          if (categories != null) {
            categories.forEach((category) {
              batch.delete(
                tableProductCategories,
                where: '${CategoryFields.productId} = ?',
                whereArgs: [category.productId],
              );
              // print("-----db--pro-create---6.1");

              category.productId = product.id;
              batch.insert(
                tableProductCategories,
                category.toJson(),
                conflictAlgorithm: ConflictAlgorithm.replace,
              );
              // print("-----db--pro-create---6.2");
            });
          }
          // print("-----db--pro-create---7");

          List<Attributes>? attributes = product.attributes;
          if (attributes != null) {
            attributes.forEach((attribute) {
              batch.insert(
                tableAttributes,
                attribute.toDBJson(),
                conflictAlgorithm: ConflictAlgorithm.replace,
              );
              // print("-----db--pro-create---7.1");

              Pivot? pivot = attribute.pivot;
              if (pivot != null) {
                batch.delete(
                  tablePivot,
                  where:
                      '${PivotFields.productId} = ? AND ${PivotFields.attributeId} = ?',
                  whereArgs: [pivot.productId, pivot.attributeId],
                );
                // print("-----db--pro-create---7.2");
                batch.insert(
                  tablePivot,
                  pivot.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace,
                );
              }
              // print("-----db--pro-create---7.3");
            });
          }

          batch.commit();
        });
        // print("-----db--pro-create---success");
      }
    } catch (e) {
      // print("db--pro--create failed");
      // print(e);
    }
  }

  Future<List<Data>?> readProducts(int? categoryId) async {
    final db = await CsvDatabse.instance.database;
    List<Data>? products;
    if (db != null) {
      await db.transaction((txn) async {
        // print("db-pro--read---1");

        final productMap = await txn.query(
          tableProduct,
          columns: ProductDataFields.values,
          // where: '${ClientFields.id} = ?',
          // whereArgs: [id],
        );
        // print("db-pro--read---");

        if (productMap.isNotEmpty) {
          products = productMap.map((json) => Data.fromJson(json)).toList();
        } else {
          // throw Exception('ID  not found');
        }
        // print("db-pro--read---3");

        if (products != null) {
          for (var product in products!) {
            List<Photos> photos = [];
            List<Categories> categories = [];
            List<Attributes> attributes = [];
            List<Pivot> pivots = [];
            final photMap = await txn.query(
              tablePhotos,
              where: '${PhotoFields.referenceId} = ?',
              whereArgs: [product.id],
            );
            // print("db-pro--read---4");

            photos = photMap.map((json) => Photos.fromJson(json)).toList();
            // print("db-pro--read---5");

            final categoryMap = await txn.query(
              tableProductCategories,
              where: '${CategoryFields.productId} = ?',
              whereArgs: [product.id],
            );
            // print("db-pro--read---6");

            categories =
                categoryMap.map((json) => Categories.fromJson(json)).toList();

            // print("db-pro--read---7");

            final pivotMap = await txn.query(
              tablePivot,
              where: '${PivotFields.productId} = ?',
              whereArgs: [product.id],
              // groupBy: PivotFields.attributeId,
            );
            // print("db-pro--read---8");

            pivots = pivotMap.map((json) => Pivot.fromJson(json)).toList();
            // print("db-pro--read---9");

            pivots.forEach((piv) async {
              final datas = await txn.query(
                tableAttributes,
                where: '${AttributeFields.id} = ?',
                whereArgs: [piv.attributeId],
              );
              // print("db-pro--read---10");

              Attributes atr =
                  datas.map((json) => Attributes.fromJson(json)).first;
              // print("db-pro--read---11");

              atr.pivot = piv;
              // print("db-pro--read---12");

              attributes.add(atr);
              // print("db-pro--read---13");
            });
            product.photos = photos;
            product.categories = categories;
            product.attributes = attributes;
            // print("db-pro--read---14");
          }
        }
      });
      if (categoryId != null) {
        if (products != null) {
          return products!
              .where((prod) => containsCategoryId(prod.categories, categoryId))
              .toList();
        }
        return [];
      }

      return products;
    }
  }
}

bool containsCategoryId(List<Categories>? cat, int? catID) {
  if (cat != null) {
    return cat.contains(catID);
  }
  return false;
}

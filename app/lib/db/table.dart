part of 'db.dart';

extension Tables on CsvDatabse {
  Future<void> cleanDatabase() async {
    final db = await CsvDatabse.instance.database;
    try {
      await db?.transaction((txn) async {
        var batch = txn.batch();
        batch.delete(tablePivot);
        batch.delete(tableAttributes);
        batch.delete(tableProductCategories);
        batch.delete(tableCategories);
        batch.delete(tablePhotos);
        batch.delete(tableProduct);
        await batch.commit();
      });
    } catch (error) {
      throw Exception('DbBase.cleanDatabase: ' + error.toString());
    }
  }

  Future<void> deleteAttr() async {
    final db = await CsvDatabse.instance.database;
    try {
      if (db != null) {
        db.delete(tableAttributes);
        await CsvDatabse._database?.close();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deletePiv() async {
    final db = await CsvDatabse.instance.database;
    try {
      if (db != null) {
        db.delete(tablePivot);
        await CsvDatabse._database?.close();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteProCat() async {
    final db = await CsvDatabse.instance.database;
    try {
      if (db != null) {
        db.delete(tableProductCategories);
        await CsvDatabse._database?.close();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deletePro() async {
    final db = await CsvDatabse.instance.database;
    try {
      if (db != null) {
        db.delete(tableProduct);
        await CsvDatabse._database?.close();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deletePhot() async {
    final db = await CsvDatabse.instance.database;
    try {
      if (db != null) {
        db.delete(tablePhotos);
        await CsvDatabse._database?.close();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> clearProductsAndCategories() async {
    final db = await CsvDatabse.instance.database;
    try {
      if (db != null) {
        print("----db is not null--");
        db.delete(tablePhotos);
        db.delete(tableAttributes);
        db.delete(tablePivot);
        // db.delete(tableCategories);
        db.delete(tableProductCategories);
        db.delete(tableProduct);

        // db.delete(tablePhotos);
        // db.delete(tableProductCategories);
        // db.delete(tableAttributes);
        // db.delete(tablePivot);
        // db.delete(tableCategories);
        // db.delete(tableProduct);
      }

      // if (db != null) {
      //   await db.transaction(
      //     (txn) async {
      //       await txn.rawDelete("delete from ${tablePivot}");
      //       await txn.rawDelete("delete from ${tableAttributes}");
      //       await txn.rawDelete("delete from ${tableProductCategories}");
      //       await txn.rawDelete("delete from ${tableCategories}");
      //       await txn.rawDelete("delete from ${tablePhotos}");
      //       await txn.rawDelete("delete from ${tableProduct}");
      //     },
      //   );
      // }
    } catch (e) {
      print("error occured while clear product");
      print(e);
    }
  }

  Future<void> clearClientsData() async {
    final db = await CsvDatabse.instance.database;
    try {
      if (db != null) {
        await db.transaction(
          (txn) async {
            await txn.rawDelete("delete from ${tableOrders}");
            await txn.rawDelete("delete from ${tableDocuments}");
            await txn.rawDelete("delete from ${tableAddresses}");
            await txn.rawDelete("delete from ${tableClients}");
          },
        );
      }
    } catch (e) {
      print("error occured while clear client data");
      print(e);
    }
  }

  Future<void> clearData() async {
    final db = await CsvDatabse.instance.database;
    try {
      if (db != null) {
        await db.transaction(
          (txn) async {
            await txn.rawDelete("delete from ${tablePivot}");
            await txn.rawDelete("delete from ${tableAttributes}");
            await txn.rawDelete("delete from ${tableProductCategories}");
            await txn.rawDelete("delete from ${tableCategories}");
            await txn.rawDelete("delete from ${tablePhotos}");
            int affected = await txn.rawDelete("delete from ${tableProduct}");
            print("deleted products-----------${affected}");

            await txn.rawDelete("delete from ${tableCartItem}");
            await txn.rawDelete("delete from ${tableUpdateOrderTable}");
            await txn.rawDelete("delete from ${tableCartAttributes}");
            await txn.rawDelete("delete from ${tableCart}");

            await txn.rawDelete("delete from ${tableRequest}");
            await txn.rawDelete("delete from ${tableDeletedClientID}");

            await txn.rawDelete("delete from ${tableOrders}");
            await txn.rawDelete("delete from ${tableDocuments}");
            await txn.rawDelete("delete from ${tableAddresses}");
            await txn.rawDelete("delete from ${tableClients}");
          },
        );
      }
    } catch (e) {
      print("error occured while clear data");
      print(e);
    }
  }
}

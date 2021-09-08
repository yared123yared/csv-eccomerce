part of 'db.dart';

extension Order on CsvDatabse {
  Future<bool> createRequest(Request req) async {
    final db = await CsvDatabse.instance.database;
    try {
      if (db != null) {
        await db.transaction((txn) async {
          print("local--req--db");
          print(jsonEncode(req).toString());
          int id = await txn.insert(
            tableRequest,
            req.toDb(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          print("db--req-create---2");

          List<Cart> carts = [];
          if (req.cart != null) {
            carts = req.cart!;
          }

          print("-----db--req-create---3");

          Batch batch = txn.batch();
          int i = 0;
          carts.forEach((cart) {
            carts[i].prodID = id;
            List<int> attributes = [];
            if (cart.selectedAttributes != null) {
              attributes = cart.selectedAttributes!;
            }

            batch.insert(
              tableCart,
              cart.toSqliteJson(),
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
            print("-----db--req-create---4");

            attributes.forEach((attr) {
              batch.insert(
                tableCartAttributes,
                {
                  'cart_id': cart.id,
                  'id': attr,
                },
                conflictAlgorithm: ConflictAlgorithm.replace,
              );
            });
            print("-----db--req-create---5");
          });
          await batch.commit();
        });
      }
    } catch (e) {
      print("---db--req---create");
      print(e);
      return false;
    }
    return true;
  }

  Future<List<Request>?> readrequests() async {
    final db = await CsvDatabse.instance.database;
    List<Request>? requests;
    if (db != null) {
      await db.transaction((txn) async {
        print("db-req--read---1");

        final reqMap = await txn.query(
          tableRequest,
          columns: RequestFields.values,
        );
        print("db-req--read---2");
        print(jsonEncode(reqMap).toString());
        if (reqMap.isNotEmpty) {
          requests = reqMap.map((json) => Request.fromDB(json)).toList();
        } else {
          // throw Exception('ID  not found')
        }
        print("db-req--read---3");

        if (requests != null) {
          int i = 0;
          for (var req in requests!) {
            List<Cart> carts = [];
            List<Categories> categories = [];
            List<Attributes> attributes = [];
            List<Pivot> pivots = [];
            final cartMap = await txn.query(
              tableCart,
              where: '${CartFields.prodID} = ?',
              whereArgs: [req.id],
            );
            print("db-req--read---4");

            carts = cartMap.map((json) => Cart.fromDb(json)).toList();
            print("db-req--read---5");

            carts.forEach((car) async {
              List<int> cartAttr = [];
              final attributes = await txn.query(
                tableCartAttributes,
                where: 'cart_id = ?',
                whereArgs: [car.id],
              );
              print("db-req--read---6");
              attributes.forEach((element) {
                cartAttr.add(element['id'] as int);
              });
              print("db-req--read---7");
              car.selectedAttributes = cartAttr;
            });
            if (requests != null) {
              requests![i].cart = carts;
            }
            i++;
            req.cart = carts;

            print("db-req--read---8");
          }
        }
      });
      print("request read from db");
      print(jsonEncode(requests).toString());
      return requests;
    }
  }

  Future<int?> deleteRequest(int id) async {
    final db = await CsvDatabse.instance.database;
    try {
      if (db != null) {
        return await db.delete(
          tableRequest,
          where: '${RequestFields.id} = ?',
          whereArgs: [id],
        );
      }
    } catch (e) {
      print("db--req--delete--error");
      print(e);
    }
  }

  Future<bool> createUpdateOrderRequest(Request req) async {
    final db = await CsvDatabse.instance.database;
    try {
      if (db != null) {
        await db.transaction((txn) async {
          print("local--order-update--db");
          print(jsonEncode(req).toString());
          int id = await txn.insert(
            tableUpdateOrderTable,
            req.toUpdateJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          print("db--order-update---1");

          List<CartItem> carts = [];
          if (req.cartItem != null) {
            carts = req.cartItem!;
          }

          print("-----db--order-update---2");

          Batch batch = txn.batch();
          carts.forEach((cart) {
            cart.orderId = id;
            batch.insert(
              tableCartItem,
              cart.toDbJson(),
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          });
          await batch.commit();
        });
      }
    } catch (e) {
      print("---db--order-update---local--failed");
      print(e);
      return false;
    }
    return true;
  }

  Future<List<Request>?> readUpdateOrderRequest() async {
    final db = await CsvDatabse.instance.database;
    List<Request>? requests;
    try {
      if (db != null) {
        await db.transaction((txn) async {
          print("db--read--order-update--1");

          final reqMap = await txn.query(
            tableUpdateOrderTable,
            columns: RequestFields.values2,
          );
          print("db--read--order-update---2");
          print(jsonEncode(reqMap).toString());
          if (reqMap.isNotEmpty) {
            requests =
                reqMap.map((json) => Request.fromUpdateDB(json)).toList();
          } else {
            // throw Exception('ID  not found');
          }
          print("db-read--order--update---3");

          if (requests != null) {
            int i = 0;
            for (var req in requests!) {
              List<CartItem> carts = [];
              final cartMap = await txn.query(
                tableCartItem,
                where: '${CartItemFields.orderID} = ?',
                whereArgs: [req.id],
              );
              print("db--read-order--update---4");
              if (cartMap.isNotEmpty) {
                print(jsonEncode(cartMap).toString());
                carts = cartMap.map((json) => CartItem.fromDB(json)).toList();
                print("db--read-order--update---5");
              }
              print("cart-items");
              // print(carts)
              if (requests != null) {
                requests![i].cartItem = carts;
              }
              i++;

              print("db--read-order--update---8");
            }
          }
        });
        print("update request read from db");
        // print(jsonEncode(requests).toString());
        if (requests != null) {
          for (var i = 0; i < requests!.length; i++) {
            print("request");
            print(jsonEncode(requests![i]));
            print("cart items");
            print(jsonEncode(requests![i].cartItem));
          }
        }
        print("finished");
        return requests;
      }
    } catch (e) {
      print("read update failed");
      print(e);
    }
  }

  Future<int?> deleteUpdateOrderRequest(int? id) async {
    final db = await CsvDatabse.instance.database;
    try {
      if (db != null) {
        return await db.delete(
          tableUpdateOrderTable,
          where: '${RequestFields.idX} = ?',
          whereArgs: [id],
        );
      }
    } catch (e) {
      print("db--update--order--delete--error");
      print(e);
    }
  }
}

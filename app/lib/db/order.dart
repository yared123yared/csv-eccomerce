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

            // attributes.forEach((attr) {
            //   batch.insert(
            //     tableCartAttributes,
            //     {
            //       'cart_id': cart.id,
            //       'id': attr,
            //     },
            //     conflictAlgorithm: ConflictAlgorithm.replace,
            //   );
            // });
            // print("-----db--req-create---5");
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

            // carts.forEach((car) async {
            //   List<int> cartAttr = [];
            //   final attributes = await txn.query(
            //     tableCartAttributes,
            //     where: 'cart_id = ?',
            //     whereArgs: [car.id],
            //   );
            //   print("db-req--read---6");
            //   // attributes.forEach((element) {
            //   //   cartAttr.add(element['id'] as int);
            //   // });
            //   // print("db-req--read---7");
            //   car.selectedAttributes = cartAttr;
            // });
            if (requests != null) {
              requests![i].cart = carts;
            }
            i++;
            // req.cart = carts;

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
}

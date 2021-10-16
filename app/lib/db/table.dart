part of 'db.dart';

extension Table on CsvDatabse {
  Future<void> clearData() async {
    final db = await CsvDatabse.instance.database;
    try {
      if (db != null) {
        await db.transaction(
          (txn) async {
            await txn.rawDelete("delete from ${tableCartItem}");
            await txn.rawDelete("delete from ${tableUpdateOrderTable}");
            await txn.rawDelete("delete from ${tableCartAttributes}");
            await txn.rawDelete("delete from ${tableCart}");

            // await txn.rawDelete("delete from ${tableRequest}");
            // await txn.rawDelete("delete from ${tableDeletedClientID}");

            await txn.rawDelete("delete from ${tableOrders}");
            await txn.rawDelete("delete from ${tableDocuments}");
            await txn.rawDelete("delete from ${tableAddresses}");
            await txn.rawDelete("delete from ${tableClients}");

            await txn.rawDelete("delete from ${tablePivot}");
            await txn.rawDelete("delete from ${tableAttributes}");
            await txn.rawDelete("delete from ${tableProductCategories}");
            await txn.rawDelete("delete from ${tableCategories}");
            await txn.rawDelete("delete from ${tablePhotos}");
            await txn.rawDelete("delete from ${tableProduct}");
          },
        );
      }
    } catch (e) {
      print("error occured while clear data");
      print(e);
    }
  }
}

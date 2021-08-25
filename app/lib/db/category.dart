part of 'db.dart';

extension CategoryLocalStore on CsvDatabse {
  Future<List<Categories>> readCategories() async {
    final db = await CsvDatabse.instance.database;
    List<Categories> categories = [];

    if (db != null) {
      print("db-cat--read---1");
      final categoryMap = await db.query(
        tableCategories,
      );
      print("db-cat--read---2");
      categories =
          categoryMap.map((json) => Categories.fromDb(json)).toList();

      print("db-cat--read---3");
    }
    return categories;
  }

  Future<void> storeCategories(List<Categories> categories) async {
    final db = await CsvDatabse.instance.database;
    if (db != null) {
      print("db-cat--create---1");
      await db.transaction((txn) async {
        Batch batch = txn.batch();
        categories.forEach((category) {
          batch.insert(
            tableCategories,
            category.toDbJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        });
        print("db-cat--create---2");
        batch.commit();
        print("db-cat--create---3");
      });
    }
  }
}

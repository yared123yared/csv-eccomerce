part of 'db.dart';

extension CategoryLocalStore on CsvDatabse {
  Future<List<Categories>> readCategories() async {
    final db = await CsvDatabse.instance.database;
    List<Categories> categories = [];

    if (db != null) {
      final categoryMap = await db.query(
        tableCategories,
      );
      categories =
          categoryMap.map((json) => Categories.fromDb(json)).toList();

    }
    return categories;
  }

  Future<void> storeCategories(List<Categories> categories) async {
    final db = await CsvDatabse.instance.database;
    if (db != null) {
      await db.transaction((txn) async {
        Batch batch = txn.batch();
        categories.forEach((category) {
          batch.insert(
            tableCategories,
            category.toDbJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        });
        batch.commit();
      });
    }
  }
}

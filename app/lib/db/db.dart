import 'package:app/models/client.dart';
import 'package:app/models/product/data.dart';
import 'package:app/models/product/photo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

part 'client.dart';
part 'order.dart';

final String tableClients = 'clients';
final String tableAddresses = 'addresses';
final String tableDocuments = 'documents';
final String tableDeletedClientID = 'deleted_clients';
final String tableProduct = 'products';
final String tablePhotos= 'photos';
final String tableCategories = 'categories';
final String tableAttributes = 'table_atributes';
final String tablePivot = 'table_pivot';

class CsvDatabse {
  static final CsvDatabse instance = CsvDatabse._init();

  static Database? _database;

  CsvDatabse._init();

  Future<Database?> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('csv.db');

    return _database;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  final textType = 'TEXT NOT NULL';
  final boolType = 'BOOLEAN NOT NULL';
  final integerType = 'INTEGER NOT NULL';
  final textTypeNullable = 'TEXT';
  final boolTypeNullable = 'BOOLEAN';
  final integerTypeNullable = 'INTEGER';
  final idTypeNullable = 'INTEGER PRIMARY KEY';

  Future _createDB(Database db, int version) async {
    try {
       await db.execute('''
CREATE TABLE $tableProduct (
  ${ProductDataFields.id} $idTypeNullable,
  ${ProductDataFields.name} $textTypeNullable,
  ${ProductDataFields.model} $textTypeNullable,
  ${ProductDataFields.price} $textTypeNullable,
  ${ProductDataFields.quantity} $integerTypeNullable,
  ${ProductDataFields.manufacturerId} $integerTypeNullable,
  ${ProductDataFields.status} $integerTypeNullable,
  ${ProductDataFields.currencyId} $integerTypeNullable,
  ${ProductDataFields.order} $integerTypeNullable
  )
''');
await db.execute('''
CREATE TABLE $tablePhotos (
  ${PhotoFields.id} $idTypeNullable,
  ${PhotoFields.referenceId} $idTypeNullable,
  ${PhotoFields.referenceType} $textTypeNullable,
  ${PhotoFields.name} $textTypeNullable,
  ${PhotoFields.forceDownload} $integerTypeNullable,
  ${PhotoFields.filePath} $textTypeNullable,
  ${PhotoFields.createdAt} $textTypeNullable
  )
''');
await db.execute('''
CREATE TABLE $tablePhotos (
  ${PhotoFields.id} $idTypeNullable,
  ${PhotoFields.referenceId} $idTypeNullable,
  ${PhotoFields.referenceType} $textTypeNullable,
  ${PhotoFields.name} $textTypeNullable,
  ${PhotoFields.forceDownload} $integerTypeNullable,
  ${PhotoFields.filePath} $textTypeNullable,
  ${PhotoFields.createdAt} $textTypeNullable
  )
''');
      await db.execute('''
CREATE TABLE $tableClients (
  ${ClientFields.id} $idType,
  ${ClientFields.firstname} $textType,
  ${ClientFields.lastname} $textType,
  ${ClientFields.mobile} $textType,
  ${ClientFields.email} $textType,
  ${ClientFields.uploadedPhoto} $textTypeNullable,
  type $textType
  )
''');
      await db.execute('''
CREATE TABLE $tableAddresses (
  ${AddressFields.id} $idType,
  ${AddressFields.clientId} $integerType,
  ${AddressFields.streetAddress} $textTypeNullable,
  ${AddressFields.zipCode} $textTypeNullable,
  ${AddressFields.locality} $textTypeNullable,
  ${AddressFields.city} $textTypeNullable,
  ${AddressFields.state} $textTypeNullable,
  ${AddressFields.country} $textType,
  ${AddressFields.isDefault} $boolType,
  ${AddressFields.isBilling} $boolType,
  ${AddressFields.companyId} $textTypeNullable,
  FOREIGN KEY (${AddressFields.clientId})
       REFERENCES $tableClients (${ClientFields.id}) ON DELETE CASCADE
  )
''');
      await db.execute('''
CREATE TABLE $tableDocuments (
  ${DocFields.id} $idType,
  ${DocFields.name} $textType,
  ${DocFields.path} $textType,
  ${DocFields.clientId} $textType,
  FOREIGN KEY (${DocFields.clientId})
       REFERENCES $tableClients (${ClientFields.id}) ON DELETE CASCADE

  )
''');

      await db.execute('''
CREATE TABLE $tableDeletedClientID (
  id $integerTypeNullable
  )
''');
    } catch (e) {
      print("db--41");
      print(e);
    }
  }

  Future close() async {
    final db = await instance.database;
    if (db != null) db.close();
  }
}

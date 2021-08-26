import 'dart:convert';

import 'package:app/models/category/categories.dart';
import 'package:app/models/client.dart';
import 'package:app/models/product/attributes.dart';
import 'package:app/models/product/data.dart';
import 'package:app/models/product/photo.dart';
import 'package:app/models/product/pivot.dart';
import 'package:app/models/request/cart.dart';
import 'package:app/models/request/request.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

part 'client.dart';
part 'order.dart';
part 'product.dart';
part 'category.dart';

final String tableClients = 'clients';
final String tableAddresses = 'addresses';
final String tableDocuments = 'documents';
final String tableOrders = 'orders';
final String tableDeletedClientID = 'deleted_clients';
final String tableProduct = 'products';
final String tablePhotos = 'photos';
final String tableCategories = 'categories';
final String tableProductCategories = 'product_categories';
final String tableAttributes = 'table_atributes';
final String tablePivot = 'table_pivot';
final String tableRequest = 'request';
final String tableCart = 'cart';
final String tableCartAttributes = 'cart_attributes';

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
      print("table create--1");
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
      print("table create--2");

      await db.execute('''
CREATE TABLE $tablePhotos (
  ${PhotoFields.id} $idTypeNullable,
  ${PhotoFields.referenceId} $integerTypeNullable,
  ${PhotoFields.referenceType} $textTypeNullable,
  ${PhotoFields.name} $textTypeNullable,
  ${PhotoFields.forceDownload} $integerTypeNullable,
  ${PhotoFields.filePath} $textTypeNullable,
  ${PhotoFields.createdAt} $textTypeNullable
  )
''');
      print("table create--3");

      await db.execute('''
CREATE TABLE $tableCategories (
  ${CategoryFields.id} $idType,
  ${CategoryFields.name} $textTypeNullable,
  ${CategoryFields.parentId} $integerTypeNullable,
  ${CategoryFields.fullname} $textTypeNullable
  )
''');
      print("table create--4");

      await db.execute('''
CREATE TABLE $tableProductCategories (
  ${CategoryFields.id} $idType,
  ${CategoryFields.name} $textTypeNullable,
  ${CategoryFields.parentId} $integerTypeNullable,
  ${CategoryFields.fullname} $textTypeNullable,
  ${CategoryFields.productId} $integerTypeNullable
  )
''');
      print("table create--5");

      await db.execute('''
CREATE TABLE $tableAttributes (
  ${AttributeFields.id} $idType,
  ${AttributeFields.name} $textTypeNullable,
  ${AttributeFields.companyId} $integerTypeNullable,
  ${AttributeFields.createdAt} $textTypeNullable,
  ${AttributeFields.updatedAt} $textTypeNullable
  )
''');
      print("table create--6");

      await db.execute('''
CREATE TABLE $tablePivot (
  ${PivotFields.productId} $idTypeNullable,
  ${PivotFields.attributeId} $integerTypeNullable,
  ${PivotFields.value} $textTypeNullable,
  ${PivotFields.unitId} $integerTypeNullable,
  ${PivotFields.unitName} $textTypeNullable,
  ${PivotFields.createdAt} $textTypeNullable,
  ${PivotFields.updatedAt} $textTypeNullable
  )
''');
      print("table create--7");

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
      print("table create--8");

      await db.execute('''
CREATE TABLE $tableAddresses (
  ${AddressFields.id} $idType,
  ${AddressFields.clientId} $integerTypeNullable,
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
      print("table create--9");

      await db.execute('''
CREATE TABLE $tableDocuments (
  ${DocFields.id} $idType,
  ${DocFields.name} $textType,
  ${DocFields.path} $textType,
  ${DocFields.clientId} $integerTypeNullable,
  FOREIGN KEY (${DocFields.clientId})
       REFERENCES $tableClients (${ClientFields.id}) ON DELETE CASCADE

  )
''');
      print("table create--10");

      await db.execute('''
CREATE TABLE $tableOrders (
  ${OrderFields.id} $idTypeNullable,
  ${OrderFields.orderNo} $textType,
  ${OrderFields.total} $textType,
  ${OrderFields.paymentWhen} $textType,
  ${OrderFields.paymentMethod} $textType,
  ${OrderFields.typeOfWallet} $textType,
  ${OrderFields.transactionId} $textType,
  ${OrderFields.amountPaid} $textType,
  ${OrderFields.amountRemaining} $textType,
  ${OrderFields.status} $textType,
  ${OrderFields.requiresApproval} $integerTypeNullable,
  ${OrderFields.addressId} $integerTypeNullable,
  ${OrderFields.clientId} $integerTypeNullable,
  ${OrderFields.companyId} $integerTypeNullable,
  ${OrderFields.createdAt} $textType,
  ${OrderFields.updatedAt} $textType,
  FOREIGN KEY (${OrderFields.clientId})
       REFERENCES $tableClients (${ClientFields.id}) ON DELETE CASCADE

  )
''');
      print("table create--11");

      await db.execute('''
CREATE TABLE $tableDeletedClientID (
  id $integerTypeNullable
  )
''');
      print("table create--12");


    await db.execute('''
CREATE TABLE $tableRequest (
  ${RequestFields.id} $idType,
  ${RequestFields.total} $integerTypeNullable,
  ${RequestFields.paymentWhen} $textType,
  ${RequestFields.paymentMethod} $textType,
  ${RequestFields.typeOfWallet} $textType,
  ${RequestFields.transactionId} $textType,
  ${RequestFields.amountPaid} $integerTypeNullable,
  ${RequestFields.amountRemaining} $integerTypeNullable,
  ${RequestFields.addressId} $integerTypeNullable,
  ${RequestFields.clientId} $integerTypeNullable
  )
''');
      print("table create--14");
await db.execute('''
CREATE TABLE $tableCart (
  ${CartFields.id} $idType,
  ${CartFields.amountInCart} $integerTypeNullable,
  ${CartFields.prodID} $integerTypeNullable,
  FOREIGN KEY (${CartFields.prodID})
       REFERENCES $tableRequest (${RequestFields.id}) ON DELETE CASCADE
  )
''');
 print("table create--15");
 await db.execute('''
CREATE TABLE $tableCartAttributes (
  cart_id $integerTypeNullable,
  id $integerTypeNullable
  FOREIGN KEY (cart_id)
       REFERENCES $tableCart (${CartFields.id}) ON DELETE CASCADE
  )
''');
      print("table create--16");
    } catch (e) {
      print("db--table--create--failed");
      print(e);
    }
  }

  Future close() async {
    final db = await instance.database;
    if (db != null) db.close();
  }
}

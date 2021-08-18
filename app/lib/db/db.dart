import 'dart:convert';

import 'package:app/models/client.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tableClients = 'clients';
final String tableAddresses = 'addresses';
final String tableDocuments = 'documents';
final String tableDeletedClientID = 'deleted_clients';

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
  Future _createDB(Database db, int version) async {
    try {
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

  Future<CreateEditData?> create(CreateEditData clientX) async {
    final db = await instance.database;
    late int clientId;
    try {
      if (db != null) {
        await db.transaction((txn) async {
          clientId = await txn.insert(tableClients, clientX.toJson());
          print("98--db---created----${clientId}");
          List<Addresses> adresses = clientX.addresses;
          List<Docs>? documents = clientX.documents;
          Batch batch = txn.batch();

          adresses.forEach((adress) {
            adress.clientID = clientId.toString();
            batch.insert(tableAddresses, adress.toSqliteJson());
          });
          if (documents != null) {
            documents.forEach((doc) {
              doc.clientID = clientId.toString();
              batch.insert(tableDocuments, doc.toJson());
            });
          }

          batch.commit();
        });
        return clientX.copy(id: clientId.toString());
      }
    } catch (e) {
      print("db--115--create failed--");
      print(e);
    }
  }

  Future<List<CreateEditData>?> readClients() async {
    // Future<List<CreateEditData>?> readClient(int id) async {
    final db = await instance.database;
    List<CreateEditData>? clients;
    if (db != null) {
      await db.transaction((txn) async {
        final clientMap = await txn.query(
          tableClients,
          columns: ClientFields.values,
          // where: '${ClientFields.id} = ?',
          // whereArgs: [id],
        );

        if (clientMap.isNotEmpty) {
          clients =
              clientMap.map((json) => CreateEditData.fromJson(json)).toList();
        } else {
          // throw Exception('ID  not found');
        }
        ;
        if (clients != null) {
          for (var cl in clients!) {
            List<Addresses> adresses = [];
            List<Docs> documents = [];
            final adressMap = await txn.query(tableAddresses,
                where: '${AddressFields.clientId} = ?', whereArgs: [cl.id]);

            adresses =
                adressMap.map((json) => Addresses.fromJson(json)).toList();

            final docsMap = await txn.query(tableDocuments,
                where: '${DocFields.clientId} = ?', whereArgs: [cl.id]);

            documents = docsMap.map((json) => Docs.fromJson(json)).toList();

            print("addresses");
            print(jsonEncode(adresses).toString());
            print("documents");
            print(jsonEncode(documents).toString());
            cl.addresses = adresses;
            cl.documents = documents;
          }
        }
      });
      print("clients");
      print(jsonEncode(clients).toString());
      return clients;
    }
  }

  Future<List<Addresses>?> readAllClientAddress(int clientID) async {
    try {
      final db = await instance.database;
      if (db != null) {
        final result = await db.query(tableAddresses,
            where: '${AddressFields.clientId} = ?', whereArgs: [clientID]);

        return result.map((json) => Addresses.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print("db--148--error fetching clients");
      print(e);
    }
  }

  Future<List<Docs>?> readAllClientDocs(int clientID) async {
    try {
      final db = await instance.database;
      if (db != null) {
        final result = await db.query(tableClients,
            where: '${DocFields.clientId} = ?', whereArgs: [clientID]);

        return result.map((json) => Docs.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print("db--163--error fetching clients");
      print(e);
    }
  }

  Future<CreateEditData?> readClient(int id) async {
    final db = await instance.database;
    if (db != null) {
      try {
        final maps = await db.query(
          tableClients,
          columns: ClientFields.values,
          where: '${ClientFields.id} = ?',
          whereArgs: [id],
        );

        if (maps.isNotEmpty) {
          return CreateEditData.fromJson(maps.first);
        } else {
          // throw Exception('ID $id not found');
          return null;
        }
      } catch (e) {
        return null;
      }
    }
  }

  Future<int?> deleteClient(int id) async {
    final db = await instance.database;
    try {
      if (db != null) {
        return await db.delete(
          tableClients,
          where: '${ClientFields.id} = ?',
          whereArgs: [id],
        );
      }
    } catch (e) {
      print("db--192--error--delete");
      print(e);
    }
  }

  Future<int?> deleteDocs(int clientId) async {
    final db = await instance.database;
    try {
      if (db != null) {
        return await db.delete(
          tableClients,
          where: '${DocFields.clientId} = ?',
          whereArgs: [clientId],
        );
      }
    } catch (e) {
      print("db--212--error--delete--doc");
      print(e);
    }
  }

  Future<int?> deleteAddress(int clientId) async {
    final db = await instance.database;
    try {
      if (db != null) {
        return await db.delete(
          tableClients,
          where: '${AddressFields.clientId} = ?',
          whereArgs: [clientId],
        );
      }
    } catch (e) {
      print("db--227--error--delete--address");
      print(e);
    }
  }

  Future<int?> deleteClientID(int clientId) async {
    final db = await instance.database;
    try {
      if (db != null) {
        return await db.delete(
          tableDeletedClientID,
          where: 'id= ?',
          whereArgs: [clientId],
        );
      }
    } catch (e) {
      print("db--294--error--delete--address");
      print(e);
    }
  }

  Future<int?> insertClientId(int id) async {
    final db = await instance.database;
    if (db != null) {
      final idX = await db.insert(tableDeletedClientID, {
        'id': id,
      });
      return idX;
    }
  }
  Future<List<int>> readAllDeletedClientIds() async {
    final db = await instance.database;


    if (db != null) {
      final result = await db.query(tableDeletedClientID,);

      return result.map((json) => json["id"] as int ).toList();
    }
    return [];
  }
}

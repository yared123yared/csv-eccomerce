part of 'db.dart';

extension ClientLocalDB on CsvDatabse {
  // ClientLocalDB(): super._init();

  Future<CreateEditData?> create(CreateEditData clientX) async {
    final db = await CsvDatabse.instance.database;
    late int clientId;
    try {
      if (db != null) {
        await db.transaction((txn) async {
          print("db--cl--create---1");
          clientId = await txn.insert(
            tableClients,
            clientX.toDbJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          print("db-cl--create---2");

          List<Addresses> adresses = clientX.addresses;
          print("-----db 2.1");

          List<Docs>? documents = clientX.documents;
          List<Orders>? orders = clientX.orders;

          print("-----db 2.2");

          Batch batch = txn.batch();
          print("-----db 2.3");
          adresses.forEach((adress) {
            adress.clientID = clientId.toString();
            print("-----db 2.4");
            print("client-id${clientId}");

            batch.insert(
              tableAddresses,
              adress.toSqliteJson(),
            );
            print("client-id${clientId}");
          });
          print("db--cl--create---3");
          if (documents != null) {
            documents.forEach((doc) {
              doc.clientID = clientId.toString();
              batch.insert(tableDocuments, doc.toDBJson());
            });
          }
          print("db--cl--create---4");
          if (orders != null) {
            orders.forEach((ord) {
              batch.insert(tableOrders, ord.toJson());
            });
          }

          batch.commit();
        });
        print("db--cl--create---4");

        return clientX.copy(id: clientId.toString());
      }
    } catch (e) {
      print("db--cl--create failed--");
      print(e);
    }
  }

  Future<CreateEditData?> updateClient(CreateEditData clientX) async {
    final db = await CsvDatabse.instance.database;
    late int clientId;
    try {
      if (db != null) {
        print("---client update started on local db");
        print("addresses--length--${clientX.addresses.length}");
        await db.transaction((txn) async {
          print("db--cl--update---1");
          clientId = await txn.update(
            tableClients,
            clientX.toDbJson(),
            where: '${ClientFields.id} = ?',
            whereArgs: [int.parse(clientX.id.toString())],
          );
          print("db--cl--update---2");

          await txn.delete(
            tableDocuments,
            where: '${DocFields.clientId} = ?',
            whereArgs: [clientId],
          );
          print("db--cl--update---3");

          await txn.delete(
            tableAddresses,
            where: '${AddressFields.clientId} = ?',
            whereArgs: [clientId],
          );
          print("db--cl--update---4");

          await txn.delete(
            tableOrders,
            where: '${OrderFields.clientId} = ?',
            whereArgs: [clientId],
          );
          print("db--cl--update---4.1");

          List<Addresses> adresses = clientX.addresses;
          List<Docs>? documents = clientX.documents;
          List<Orders>? orders = clientX.orders;

          Batch batch = txn.batch();

          adresses.forEach((adress) {
            adress.clientID = clientId.toString();
            batch.insert(tableAddresses, adress.toSqliteJson());
          });
          print("db--cl--update---5");

          if (documents != null) {
            documents.forEach((doc) {
              doc.clientID = clientId.toString();
              batch.insert(tableDocuments, doc.toDBJson());
            });
          }
          print("db--cl--update---5-1");

          if (orders != null) {
            orders.forEach((ord) {
              batch.insert(tableOrders, ord.toJson());
            });
          }
          print("db--cl--update---6");
          batch.commit();
          print("db--cl--update---7");
        });
        return clientX.copy(id: clientId.toString());
      }
    } catch (e) {
      print("db--cl--update failed--");
      print(e);
    }
  }

  Future<void> deleteAllClients() async {
    final db = await CsvDatabse.instance.database;
    try {
      if (db != null) {
        await db.transaction(
          (txn) async {
            await txn.delete(
              tableAddresses,
            );
            await txn.delete(
              tableDocuments,
            );
            await txn.delete(
              tableOrders,
            );
            await txn.delete(
              tableClients,
            );
          },
        );
      }
    } catch (e) {}
  }

  Future<List<CreateEditData>?> readClients() async {
    // Future<List<CreateEditData>?> readClient(int id) async {
    final db = await CsvDatabse.instance.database;
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
            List<Orders> orders = [];
            final adressMap = await txn.query(
              tableAddresses,
              where: '${AddressFields.clientId} = ?',
              whereArgs: [cl.id],
            );

            adresses = adressMap
                .map(
                  (json) => Addresses.fromJson(json),
                )
                .toList();

            final docsMap = await txn.query(
              tableDocuments,
              where: '${DocFields.clientId} = ?',
              whereArgs: [cl.id],
            );

            documents = docsMap
                .map(
                  (json) => Docs.fromJson(json),
                )
                .toList();
            if (cl.id != null) {
              final ordersMap = await txn.query(
                tableOrders,
                where: '${OrderFields.clientId} = ?',
                whereArgs: [int.parse(cl.id as String)],
              );

              orders = ordersMap
                  .map(
                    (json) => Orders.fromJson(json),
                  )
                  .toList();
            }

            // print("addresses");
            // print(jsonEncode(adresses).toString());
            // print("documents");
            // print(jsonEncode(documents).toString());
            cl.addresses = adresses;
            cl.documents = documents;
            cl.orders = orders;
          }
        }
      });
      // print("clients");
      // print(jsonEncode(clients).toString());
      return clients;
    }
  }

  Future<List<CreateEditData>?> searchClients(String key) async {
    // Future<List<CreateEditData>?> readClient(int id) async {
    final db = await CsvDatabse.instance.database;
    List<CreateEditData>? clients;
    if (db != null) {
      await db.transaction((txn) async {
        final clientMap = await txn.query(
          tableClients,
          columns: ClientFields.values,
          where: '${ClientFields.firstname} Like ?',
          whereArgs: ["%${key}%"],
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
            List<Orders> orders = [];
            final adressMap = await txn.query(
              tableAddresses,
              where: '${AddressFields.clientId} = ?',
              whereArgs: [cl.id],
            );

            adresses = adressMap
                .map(
                  (json) => Addresses.fromJson(json),
                )
                .toList();

            final docsMap = await txn.query(
              tableDocuments,
              where: '${DocFields.clientId} = ?',
              whereArgs: [cl.id],
            );

            documents = docsMap
                .map(
                  (json) => Docs.fromJson(json),
                )
                .toList();
            if (cl.id != null) {
              final ordersMap = await txn.query(
                tableOrders,
                where: '${OrderFields.clientId} = ?',
                whereArgs: [int.parse(cl.id as String)],
              );

              orders = ordersMap
                  .map(
                    (json) => Orders.fromJson(json),
                  )
                  .toList();
            }

            // print("addresses");
            // print(jsonEncode(adresses).toString());
            // print("documents");
            // print(jsonEncode(documents).toString());
            cl.addresses = adresses;
            cl.documents = documents;
            cl.orders = orders;
          }
        }
      });
      // print("clients");
      // print(jsonEncode(clients).toString());
      return clients;
    }
  }

  Future<List<Addresses>?> readAllClientAddress(int clientID) async {
    try {
      final db = await CsvDatabse.instance.database;
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
      final db = await CsvDatabse.instance.database;
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
    final db = await CsvDatabse.instance.database;
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
    final db = await CsvDatabse.instance.database;
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
    final db = await CsvDatabse.instance.database;
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
    final db = await CsvDatabse.instance.database;
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
    final db = await CsvDatabse.instance.database;
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
    final db = await CsvDatabse.instance.database;
    if (db != null) {
      final idX = await db.insert(tableDeletedClientID, {
        'id': id,
      });
      return idX;
    }
  }

  Future<List<int>> readAllDeletedClientIds() async {
    final db = await CsvDatabse.instance.database;

    if (db != null) {
      final result = await db.query(
        tableDeletedClientID,
      );

      return result.map((json) => json["id"] as int).toList();
    }
    return [];
  }

  Future<int?> updateClientDataStatus(CreateEditData clientX) async {
    final db = await CsvDatabse.instance.database;
    if (db != null) {
      print("update client data status");
      return db.update(
        tableClients,
        clientX.toJson(),
        where: '${ClientFields.id} = ?',
        whereArgs: [clientX.id],
      );
    }
  }
}

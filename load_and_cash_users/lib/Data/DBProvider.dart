
import 'dart:io';
import 'package:load_and_cash_users/Models/Client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DBProvider {
  /*
  Создайте частный конструктор, который 
  можно использовать только внутри класса:
  */
  DBProvider._();
  static final DBProvider db = DBProvider._();


  static Database _database;

  Future<Database> get database async {
    if (_database != null){
      return _database;
    }

    // если _database имеет значение null, мы создаем его экземпляр
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db"); //имя базы данных
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Client (" //модель клиент и ее поля
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "username TEXT,"
          "email TEXT"
          ")");
    });
  }


  newClient(Client newClient) async {
    final db = await database;
    var res = await db.insert("Client", newClient.toMap);
    return res;
  }

  newClients(List<Client> newClients) async {
    final db = await database;
    newClients.forEach((element) async { 
      await db.insert("Client", element.toMap);
    });
  }

  newClientFromJson(Map<String, dynamic> json) async {
    final db = await database;
    var res = await db.insert("Client", json);
    return res;
  }

  newClientsFromJson(List<Map<String, dynamic>> jsons) async {

    List<Client> clients = jsons.map((json) => Client.fromMap(json)).toList();

    final db = await database;
    clients.forEach((element) async { 
      await db.insert("Client", element.toMap);
    });

    return clients;
  }

  

  //использование самого большого id для нового клиента
  // newClient3(Client newClient) async {
  //   final db = await database;
  //   //get the biggest id in the table
  //   var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Client");
  //   int id = table.first["id"];
  //   //insert to the table using the new id 
  //   var raw = await db.rawInsert(
  //       "INSERT Into Client (id,first_name,last_name,blocked)"
  //       " VALUES (?,?,?,?)",
  //       [id, newClient.name, newClient.lastName, newClient.blocked]);
  //   return raw;
  // }

  //получение клиента по id
  getClient(int id) async {
    final db = await database;
    var res =await  db.query("Client", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Client.fromMap(res.first) : Null ;
  }

  //получение всех клиентов

  Future<List<Client>> getAllClients() async {
    final db = await database;
    var res = await db.query("Client");
    List<Client> list =
        res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }

  //получение только заблокированных клиентов

  getBlockedClients() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
    List<Client> list =
        res.isNotEmpty ? res.toList().map((c) => Client.fromMap(c)) : null;
    return list;
  }


  //Обновить существующего клиента

  updateClient(Client newClient) async {
    final db = await database;
    var res = await db.update("Client", newClient.toMap,
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  //Пример: заблокировать или разблокировать клиента:

  // blockOrUnblock(Client client) async {
  //   final db = await database;
  //   Client blocked = Client(
  //       id: client.id,
  //       name: client.name,
  //       username: client.username,
  //       email: client.email);

  //   var res = await db.update("Client", blocked.toMap,
  //       where: "id = ?", whereArgs: [client.id]);
  //   return res;
  // }

  //удалить клиента


deleteClient(int id) async {
    final db = await database;
    db.delete("Client", where: "id = ?", whereArgs: [id]);
  }

  //удалить всех клиентов

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Client");
  }

}
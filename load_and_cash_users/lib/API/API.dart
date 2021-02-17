
import 'package:http/http.dart' as http;
import 'package:load_and_cash_users/Data/DBProvider.dart';
import 'dart:convert';
import 'package:load_and_cash_users/Models/Client.dart';
import 'package:sqflite/sqlite_api.dart';


class ClientProvider {

  Future getUser() async {

    final response = await http.get('https://jsonplaceholder.typicode.com/users');

    if (response.statusCode == 200){
      print("-----------------");
      final List<dynamic> userJson = json.decode(response.body);
      final List<Client> clients = userJson.map((json) => Client.fromJson(json)).toList();

      DBProvider.db.newClientsList(clients);
    } else {
      throw Exception('---------ERROR---------');
    }

  }

    
}
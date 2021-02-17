
import 'package:http/http.dart' as http;
import 'package:load_and_cash_users/Data/DataBase.dart';
import 'dart:convert';
import 'package:load_and_cash_users/Models/Client.dart';
import 'package:sqflite/sqlite_api.dart';


class ClientProvider {

  // Future значит обещание, 
  // Future <>

  Future<List<Client>> getUser() async {
  //final значет не будет изменен другими классами
  //await применяем при async работе
    final response = await http.get('https://jsonplaceholder.typicode.com/users');

    if (response.statusCode == 200){
      final List<dynamic> userJson = json.decode(response.body);
      DBProvider.db.newClientsFromJson(userJson);
      return DBProvider.db.getAllClients();
    } else {
      throw Exception('---------ERROR---------');
    }

  }

    
}
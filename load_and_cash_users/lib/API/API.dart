
import 'package:http/http.dart' as http;
import 'package:load_and_cash_users/Data/DBProvider.dart';
import 'dart:convert';
import 'package:load_and_cash_users/Models/Client.dart';
import 'package:sqflite/sqlite_api.dart';


class ClientProvider {

  // Future значит обещание, 
  // Future <>

  getUser() async {
  //final значет не будет изменен другими классами
  //await применяем при async работе
    final response = await http.get('https://jsonplaceholder.typicode.com/users');

    if (response.statusCode == 200){
      final List<dynamic> userJson = json.decode(response.body);
      DBProvider.db.newClientsFromJson(userJson);
    } else {
      throw Exception('---------ERROR---------');
    }

  }

    
}
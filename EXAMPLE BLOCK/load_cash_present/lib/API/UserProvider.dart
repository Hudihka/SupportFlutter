
import 'package:http/http.dart' as http;
import 'package:load_cash_present/Data/DBProvider.dart';
import 'dart:convert';
import 'package:load_cash_present/Models/User.dart';

class UserProvider {
  // Future значит обещание, 
  // Future <>

  Future getUser() async {
  //final значет не будет изменен другими классами
  //await применяем при async работе
    final response = await http.get('https://jsonplaceholder.typicode.com/users');

    if (response.statusCode == 200){
      print("-----------------");
      final List<dynamic> userJson = json.decode(response.body);
      final List<User> clients = userJson.map((json) => User.fromJson(json)).toList();

      await DBProvider.db.newUsersList(clients);
    } else {
      throw Exception('---------ERROR---------');
    }

  }

    
}
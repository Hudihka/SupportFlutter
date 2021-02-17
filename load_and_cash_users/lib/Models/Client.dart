

import 'dart:convert';

import 'package:flutter/material.dart';


class Client {

  int id;
  String name;
  String username;
  String email;

  Client({@required this.id, this.name, this.username, this.email}) : assert(id != null);

  factory Client.fromJson(Map<String, dynamic> json) {
      return Client(id: json['id'], name: json['name'], username: json['username'], email: json['email']);
  }

    Map<String, dynamic> get toMap{
        return {"id": id,
        "name": name,
        "username": username,
        "email": email};
      }

}

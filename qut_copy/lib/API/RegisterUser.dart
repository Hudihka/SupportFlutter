import 'package:flutter/material.dart';
import 'package:qut/Models/Content.dart';

import 'Base/BaseRequest.dart';
import 'Base/QUTError.dart';

class RegisterUser extends BaseRequest {

  String name;
  String email;

  RegisterUser({@required this.name, @required this.email});

  @override
  String get strUrl {
    return "registartion";
  }


  @override
  Map<String, String> parametrs(){
    return {'name': name, 'email': email};
  }
  
  @override
  handleOne({Map<String, dynamic> json, QUTError error}) async {

    Content content = Content.fromJson(json);
    endRequestJson(obj: content, error: error);

  }

}
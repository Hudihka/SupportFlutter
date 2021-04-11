import 'package:flutter/material.dart';
import 'package:qut/API/Base/BaseRequest.dart';
import 'package:qut/API/Base/QUTError.dart';
import 'package:qut/Models/Content.dart';
import 'package:qut/Models/Dictionary.dart';

class GetContentText extends BaseRequest {

  String id;

  GetContentText({@required this.id});


  @override
   String get strUrl {
    return "content-feed/$id";
  }
  
  @override
  handleOne({Map<String, dynamic> json, QUTError error}) async {

    if (error != null){
      endRequestListJson(objs: [], error: error);
    } else {
      Content content = Content.fromJson(json);
      endRequestJson(obj: content, error: error);
    }
  }


}    
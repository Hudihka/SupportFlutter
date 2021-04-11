


import 'package:flutter/material.dart';
import 'package:qut/API/Base/BaseRequest.dart';
import 'package:qut/API/Base/QUTError.dart';
import 'package:qut/Models/Dictionary.dart';
import 'package:qut/Views/Curtains/TagsCurtain/TagsCurtainSingelton.dart';

class GetDictionariesSlug extends BaseRequest {

  String slug;

  GetDictionariesSlug({@required this.slug});


  @override
  String get strUrl {
    return "dictionaries/$slug/dictionary-items";
  }
  
  @override
  handleOne({Map<String, dynamic> json, QUTError error}) async {

    if (error != null){
      endRequestListJson(objs: [], error: error);
    } else {
      List<dynamic> data = json['data'];
      
      //это все что пришли
      List<Dictionary> listContent = Dictionary.fromListOfMap(data);
      TagsCurtainSingelton.shared.removeOldDictionary(listContent);



      endRequestListJson(objs: listContent, error: error);
    }


  }

}
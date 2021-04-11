

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qut/API/Base/BaseRequest.dart';
import 'package:qut/API/Base/QUTError.dart';
import 'package:qut/Models/Dictionary.dart';
import 'package:qut/Views/Curtains/TagsCurtain/TagsCurtainSingelton.dart';

//!!!!!!!!!!!!!
//запрс будет работать только если пользователь зареган
class ReloadFavoritCategory extends BaseRequest {

  @override
  String get strUrl {
    return "self/category";
  }

  @override
  EnumMetods metods = EnumMetods.postReq;

  @override
  Map<String, dynamic> parametrs(){

    Map<String, dynamic> par = {};

    par["content_category_ids"] = [];

    List<String> list = TagsCurtainSingelton.shared.getListDictionary.map((e) => e.id).toList();
    par["content_category_ids"] = list;

    return par;
  }
  
  @override
  handleOne({Map<String, dynamic> json, QUTError error}) async {

    if (error != null){
      endRequestListJson(objs: [], error: error);
    } else {
      List<dynamic> data = json['data'];
      List<Dictionary> listContent = Dictionary.fromListOfMap(data);
      TagsCurtainSingelton.shared.setNewSelectedDictionary(listContent);


      endRequestListJson(objs: [], error: null);
    }
  }

}
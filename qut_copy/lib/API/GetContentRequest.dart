import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qut/Models/Content.dart';
import 'package:qut/Support/LogOuth/DefaultUtils.dart';
import 'package:qut/Views/Curtains/TagsCurtain/TagsCurtain.dart';
import 'package:qut/Views/Curtains/TagsCurtain/TagsCurtainSingelton.dart';
import 'Base/BaseRequest.dart';
import 'Base/QUTError.dart';

class GetContentRequest extends BaseRequest {

  String search;
  bool favorite;
  int page;

  EnumContentTupeCell type;

  @override
  String get strUrl {
    return "content-feed/";
  }


  GetContentRequest({this.search, this.favorite, this.type, this.page});

  //для теста используй demo/demo

  @override
  Map<String, dynamic> parametrs(){

    Map<String, dynamic> par = {};

    if (search != null) {
      par['search'] = search;
    }

    if (favorite != null) {
      par['favorite'] = favorite ? '1' : '0';
    }

    if (page != null) {
      par['per_page'] = '$page';
    }

    // final list = TagsCurtain.selectedListItems;
    final singlton = TagsCurtainSingelton.shared;
    final list = singlton.getListDictionary;

    if (list.isNotEmpty){
      List<String> listStr = [];
      for (var i in list){
        listStr.add(i.id);
      }

      par['dictionary_items[]'] = listStr;
    }

    final typeStr = this.type.backendParametr ?? singlton.getSelectedType.backendParametr;

    if (typeStr != null) {
      par['type'] = typeStr;
    }


    return par;
  }

  
  @override
  handleOne({Map<String, dynamic> json, QUTError error}) async {

    if (error != null){
      endRequestJson(error: error);
    } else {
      List<dynamic> data = json['data'];
      List<Content> listContent = Content.fromListOfMap(data);

      Map<String, dynamic> dataMeta = json['meta'] ?? {'total': 0};
      int total = dataMeta['total'] ?? 0;

      endRequestJson(obj: {'total':total, 'data': listContent}, error: error);
    }

    // List<dynamic> data = json['data'];
    // List<Content> listContent = Content.fromListOfMap(data);
    // endRequestListJson(objs: listContent, error: error);
    // print(listContent.first.id);

  }

}
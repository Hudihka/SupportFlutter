
import 'package:flutter/material.dart';

class LastContext {

  static List<BuildContext> _listContext = [];

  static addContext(BuildContext context){
    _listContext.add(context);
  }

  static removeLastContext(BuildContext context){
    _listContext.removeLast();
  }

  static BuildContext get getContext {
    return _listContext.last;
  }

}
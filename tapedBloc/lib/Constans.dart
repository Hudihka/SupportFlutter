
import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;


class Const {

  static double wDevice(BuildContext cont){
    return MediaQuery.of(cont).size.height;
  }

  static double hDevice(BuildContext cont){
    return MediaQuery.of(cont).size.height;
  }

  static bool get itIOS {
    return Platform.isIOS;
  }

  static bool get itAndroid {
    return Platform.isAndroid;
  }

  //методы для иос

  static bool isIPhone5(BuildContext cont) {
    return hDevice(cont) == 568;
  }

  static bool isIPhoneXorXmax(BuildContext cont) {
    return hDevice(cont) >= 812;
  }

  static int statusBarHeight(BuildContext cont) {
    return isIPhoneXorXmax(cont) ? 44 : 20;
  }

  static int get navigBarHeight{
    return 44;
  }

  static int fullHeightNB(BuildContext cont) {
    return statusBarHeight(cont) + navigBarHeight;//88 : 64
  } 

  static int heightTabBar(BuildContext cont) {
    return isIPhoneXorXmax(cont) ? 84 : 58;
  }

}


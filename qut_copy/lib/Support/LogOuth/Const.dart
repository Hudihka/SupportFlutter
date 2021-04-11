import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:qut/Extension/String.dart';



class Const {

  //COLOR

  static Color veryLightGray = 'EDEDED'.getColor();
  static Color darkGray      = '45484F'.getColor();
  static Color midleGray     = '9EA2A2'.getColor();
  static Color lightGray     = 'AFBAC8'.getColor();
  static Color blue          = '5689C0'.getColor();
  static Color indigo        = '715AFF'.getColor();
  static Color devil         = '666666'.getColor();


  //IMAGE

  static String iconWay(String nameIcon){
    return 'assets/icons/$nameIcon';
  }

  static String imageWay(String nameIcon){
    return 'assets/images/$nameIcon';
  }

  //SIze devise

  static double hDevice = 0;
  static double wDevice = 0;
  static double statusBarHeight = 0;

  static setSize(BuildContext cont){
    final size = MediaQuery.of(cont).size;

    hDevice = size.height;
    wDevice = size.width;

    statusBarHeight = MediaQuery.of(cont).padding.top;
  }

  static bool get itIOS {
    return Platform.isIOS;
  }

  static bool get itAndroid {
    return Platform.isAndroid;
  }

  static double get heightVideo {
    return Const.wDevice * 216 / 375;
  }

  //методы для иос

  static bool get isIPhone5 {
    return hDevice == 568;
  }

  static bool get isIPhoneXorXmax {
    return hDevice >= 812;
  }


  static int get navigBarHeight{
    return 44;
  }


  static int get heightTabBar {
    return isIPhoneXorXmax ? 84 : 58;
  }

  //методы для андроида



  //методы сразу для 2х систем


  static double get fullHeightNB {
    return AppBar().preferredSize.height + statusBarHeight;//88 : 64
  } 

   static double get fullHeightBody {
    return Const.hDevice - Const.fullHeightNB;
  } 

}


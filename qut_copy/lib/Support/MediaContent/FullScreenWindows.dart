import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qut/Cubits/TabBarCubit.dart';
import 'package:qut/Models/Content.dart';
import 'package:qut/Support/MediaContent/PlayerWidget.dart';
import 'package:qut/Views/MiniPlayerWidget.dart';
import '../LogOuth/Const.dart';

class FullScreenWindows extends StatelessWidget {
  // Widget mediaContent;
  PlayerWidget widgetMedia;

  FullScreenWindows({@required this.widgetMedia});

  TabBarCubit get _tabBarCubit {
    return MiniPlayerSingelton.shared.getCubit;
  }

  Content get _content {
    return _tabBarCubit.contentState.contentSelected;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: RotatedBox(quarterTurns: 1, child: Center(
          child: Container(
            height: Const.wDevice,
            width: Const.hDevice,
            // color: Colors.yellow,
            child: widgetMedia,
          )
        )));

  }

  


}

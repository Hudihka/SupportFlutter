
import 'dart:ui';
import 'package:flutter/material.dart';
import 'LogOuth/Const.dart';

class LoadWindows extends StatelessWidget {

  static bool _isPushed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Center(
        child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Const.darkGray),)
      ),
      ),
    );
  }

  static presentLoad(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(transitionDuration: Duration(milliseconds: 10),
          pageBuilder: (context, _, __) {
            _isPushed = true;
            return LoadWindows();
          }, opaque: false),
    );
  }

  static dissmisLoad(BuildContext context) {
    if (_isPushed){
      _isPushed = false;
      Navigator.of(context).pop();
    }
  }

}

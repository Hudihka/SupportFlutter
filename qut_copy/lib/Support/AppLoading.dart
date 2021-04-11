import 'package:flutter/material.dart';
import 'package:qut/Support/LogOuth/Const.dart';

class AppLoading extends StatelessWidget {
  final bool fullScreen;

  const AppLoading({Key key, this.fullScreen = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loading = CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Const.darkGray));

    if (fullScreen) return Container(child: Center(child: loading));

    return Container(child: loading);
  }
}

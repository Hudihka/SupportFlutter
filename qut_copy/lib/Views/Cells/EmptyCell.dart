import 'package:flutter/material.dart';
import 'package:qut/Support/LogOuth/Const.dart';

class EmptyCell extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
        height: Const.navigBarHeight.toDouble(),
        width: double.infinity,
        color: Colors.white,);
  }
}
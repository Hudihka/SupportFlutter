import 'package:flutter/material.dart';
import 'package:qut/Support/LogOuth/Const.dart';

class CellTag extends StatelessWidget {
  
  String text;
  Color colorBorder;
  Color colorText;
  Color colorBacground;

  CellTag(this.text, this.colorBorder, this.colorText, this.colorBacground);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: colorBacground,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: colorBorder, width: 1),
        ),
        child: Padding(
            padding: EdgeInsets.only(left: 14, top: 5, right: 14, bottom: 5),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: colorText),
              ),
            )));
  }
}
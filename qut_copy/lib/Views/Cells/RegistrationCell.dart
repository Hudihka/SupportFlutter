import 'package:flutter/material.dart';
import 'package:qut/Support/LogOuth/Const.dart';
import 'package:qut/Extension/String.dart';

class RegistrationCell extends StatelessWidget {

  Function tapedRegistration;
  
    @override
    Widget build(BuildContext context) {
      return Container(
        height: 300,
        color: Colors.transparent,
        child: _column
      );
    }
  
    Column get _column {
      return Column(
        children: [
          SizedBox(
            height: 50
          ),
          Text(
            "That's all for now 😨",
            textAlign: TextAlign.center,
            style: TextStyle(color: Const.darkGray, fontSize: 24, fontWeight: FontWeight.bold), 
          ),
          SizedBox(
            height: 35
          ),
          Text(
            "You can get up to 50 videos.\n Register to get access to unlimited\n QUT content",
            textAlign: TextAlign.center,
            style: TextStyle(color: Const.lightGray, fontSize: 16, fontWeight: FontWeight.w400), 
          ),
          SizedBox(
            height: 40
          ),
          _button
        ],
      );
    }
  
    Widget get _button {
      return Container(
    width: Const.wDevice - 76,
    height: 50.0,
    child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    )
  ),
          backgroundColor: MaterialStateProperty.all(Const.blue), //Background Color
          elevation: MaterialStateProperty.all(3), //Defines Elevation
          shadowColor: MaterialStateProperty.all(Colors.transparent), //Defines shadowColor
        ),
        onPressed: () {
          tapedRegistration();
        },
        child: Text('Registration', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
        ),
  );
    }
  
  
  }
  

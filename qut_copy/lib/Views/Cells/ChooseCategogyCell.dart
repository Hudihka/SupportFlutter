import 'package:flutter/material.dart';
import 'package:qut/Support/LogOuth/Const.dart';
import 'package:qut/Extension/String.dart';
import 'package:qut/Views/Cells/RegistrationCell.dart';

class ChooseCategogyCell extends StatelessWidget {
  Function tapedCategorus;

  @override
  Widget build(BuildContext context) {
    return Container(height: 330, color: Colors.transparent, child: _column);
  }

  Column get _column {
    return Column(
      children: [
        SizedBox(height: 50),
        Text(
          "Do you want to watch \n what you like? 😉",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Const.darkGray, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 22),
        Text(
          "Choose your favorite \n categories and don't waste time \n on uninteresting content",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Const.lightGray,
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 39),
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
            )),
            backgroundColor:
                MaterialStateProperty.all(Const.blue), //Background Color
            elevation: MaterialStateProperty.all(3), //Defines Elevation
            shadowColor: MaterialStateProperty.all(
                Colors.transparent), //Defines shadowColor
          ),
          onPressed: () {
            tapedCategorus();
          },
          child: Text(
            'Choose category',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ));
  }
}

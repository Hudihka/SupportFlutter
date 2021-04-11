import 'package:flutter/material.dart';
import 'package:qut/Support/LogOuth/Const.dart';
import 'package:qut/Extension/String.dart';
import 'package:qut/Views/Curtains/ThreeButtonCurtain.dart';



class TwoButtonCurtain extends StatelessWidget {
  List<String> texts;
  Function(EnumTapedButtonCurtain enumValue) actionTaped;

  TwoButtonCurtain({@required this.texts});

  Widget build(BuildContext context) {
    return Container(
      height: 202, 
      color: Colors.white, 
      child: _column,
    );
  }

  Column get _column {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          width: 70,
          height: 5,
          // color: Colors.black.withAlpha(30),
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(30),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(height: 25),
        _button(0),
        _separator,
        _button(1),
      ],
    );
  }

  Widget _button(int index) {
    final colorCode = index == 1 ? 'FF6B6B' : '45484F';

    final text = Text(
      texts[index],
      style: TextStyle(
          color: colorCode.getColor(),
          fontSize: 18,
          fontWeight: FontWeight.w600),
    );

    return Container(
      width: Const.wDevice,
      height: 50.0,
      child: RaisedButton(
        onPressed: () {
          final value = index == 0 ? EnumTapedButtonCurtain.top : EnumTapedButtonCurtain.down;
          actionTaped(value);
        },
        color: Colors.white,
        child: text,
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
      ),
    );
  }

  Widget get _separator {
    return Container(
      width: Const.wDevice - 34,
      height: 1,
      color: Colors.black.withAlpha(10),
    );
  }
}


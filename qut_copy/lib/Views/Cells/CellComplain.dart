

import 'package:flutter/material.dart';
import 'package:qut/Extension/String.dart';
import 'package:qut/Support/LogOuth/Const.dart';

class CellComplain extends StatelessWidget {
  String content;
  bool selected;

  Function(String content) taped;

  CellComplain({@required this.content, @required this.selected});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        taped(content);
      },
      child: _content(),
    );
  }

  Container _content(){
    return Container(
      color: Colors.white,
      height: 44,
      width: double.infinity,
      child: Column(children: [
          SizedBox(height: 12,),
          _row(),
          SizedBox(height: 11,),
          _rowSeparator()
      ])
    );
  }

  Row _row(){

    final listFondation = [
      SizedBox(width: 16, height: 20,),
      Text(content, textAlign: TextAlign.left, 
           style: TextStyle(color: Const.darkGray, fontSize: 14, fontWeight: FontWeight.w400),)
    ];


    if (selected){
      listFondation.add(Spacer());
      listFondation.add(SizedBox(width: 27,));
      listFondation.add(Container(
        height: 20,
        width: 20,
        child: Image.asset('assets/icons/chekComplain.png'),
      ));
      listFondation.add(SizedBox(width: 16,));
    }

    return Row(children: listFondation);
  }

  Row _rowSeparator(){
    return Row(
      children: [
        SizedBox(width: 16),
        Container(
          width: Const.wDevice - 34,
          height: 1,
          color: Colors.black.withAlpha(10),
    ),
    SizedBox(width: 16),
      ]
    );
  }



}     
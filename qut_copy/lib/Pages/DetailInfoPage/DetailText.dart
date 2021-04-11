import 'package:flutter/material.dart';
import 'package:qut/Models/Content.dart';
import 'package:qut/Support/LogOuth/Const.dart';
import 'package:qut/Views/BBItem/BBItem.dart';

class DetailText extends StatelessWidget {
  final Content content;
  DetailText({@required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        actions: [
          BBItem(
              shadow: false,
              imageName: 'assets/icons/BBItem/BBItemClose.png',
              action: () {
                Navigator.pop(context);
              }),
        ],
      ),
      body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 5),
                  child: Text(content.name, 
                  maxLines: 3,
                  style: TextStyle(color: Const.darkGray, fontSize: 24, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 60),
                  child: Text(content.text_qut, 
                  style: TextStyle(color: Const.darkGray, fontSize: 16, fontWeight: FontWeight.w400),),
                ),
              ],
            ),
          )),
    );
  }
}

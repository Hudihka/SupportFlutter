

import 'package:flutter/material.dart';
import 'package:qut/API/Base/QUTError.dart';
import 'package:qut/Extension/Aler.dart';
import 'package:qut/Models/Content.dart';
import 'package:qut/Pages/Complain.dart';
import 'package:qut/Views/Curtains/TwoButtonCurtain.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qut/Views/Curtains/ThreeButtonCurtain.dart';

class ShowView{

  static showAlertError(QUTError error, BuildContext context) {
    final alert = AlertOneButton('Ошибка', error.errorDescription, () {}, 'Ok');
    showDialog(context: context, builder: (BuildContext context) => alert);
  }


  static presentCurtain(Widget curtain, BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        elevation: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (BuildContext bc) {
          return curtain;
        });
  }


    static curtainTwoButton(BuildContext context, Content content){
      List<String> list = ['View full version', 'Complain'];
      final curtain = TwoButtonCurtain(texts: list);
      curtain.actionTaped = (enumValue) {
        Navigator.pop(context);

        if (enumValue == EnumTapedButtonCurtain.top) {
          final url = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';
          ShowView.openURL(url);
          // html.window.open(url, 'hvhvhvh');
        } else {
                    final compl = Complain(content: content);
          Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => compl, fullscreenDialog: true),
      );

        } 
      };

      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        elevation: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (BuildContext bc) {
          return curtain;
        });
  }


  static openURL(String url) async {
    if (await canLaunch(url)) {
        await launch(url);
  } else {
    throw 'Could not launch $url';
  }
  }



}
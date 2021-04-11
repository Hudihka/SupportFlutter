import 'package:flutter/material.dart';
import 'package:qut/Pages/TabBar/WidgetTabBar.dart';
import 'package:qut/Views/BBItem/BBItem.dart';
import 'package:qut/imports.dart';

export 'package:qut/Pages/TabBar/WidgetTabBar.dart';


class SettingsPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: BBItem(
            shadow: false,
            imageName: 'assets/icons/BBItem/BBItemBack.png',
            action: () {
              Navigator.of(context).pop();
            }),
      ),
      body: _bodyContent(),
      backgroundColor: Colors.white,
    );
  }

  Widget _bodyContent() {
    return Center(
      child: RaisedButton(
        color: Const.blue,
        child: Text('Log out',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16)),
        onPressed: () {
                LogOuthUser.logOuth();
              },),
    );

  }


}

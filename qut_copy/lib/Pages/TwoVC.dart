import 'package:flutter/material.dart';

import '../API/Base/ReloadTokens.dart';

class TwoVC extends StatelessWidget {

  String textCont;

  TwoVC({@required this.textCont});

  _reloadToken(BuildContext context){
    ReloadTokens reloadTokwnsReq = ReloadTokens(); //обнавляем токен
    reloadTokwnsReq.load();

    reloadTokwnsReq.fortunately = (){
        print('обновили токен');
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Two vc'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(textCont),

          ],
        ),
      ),
    );
  }
}
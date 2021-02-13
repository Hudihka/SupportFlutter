import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:two_vc_and_block/PushVC.dart';
import 'package:two_vc_and_block/PresentVC.dart';

class StartVC extends StatefulWidget {
  StartVC({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _StartVCState createState() => _StartVCState();
}

class _StartVCState extends State<StartVC> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Counter count ${_counter}',
              style: TextStyle(fontSize: 25, color: Colors.red),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly, //весь контент разделен одинак расстоянием
                children: <Widget>[_pushVC(), Text('Пуш ВК и ++ к счетчику')]),
            SizedBox(
              height: 100,
            ), //расстояние между ними
            Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, //весь контент собран по центру
                children: <Widget>[
                  _presentVC(),
                  Text('Пресент ВК и -- к счетчику')
                ]),
          ],
        ),
      ),
    );
  }

  FlatButton _pushVC() {
    return FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PushVC()),
          );
        },
        textColor: Colors.red,
        color: Colors.blue,
        child: Text(
          "++",
        ));
  }

  FlatButton _presentVC() {
    return FlatButton(
      onPressed: () {
        // presentVC
        Navigator.of(context).push(
          CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => PresentVC(),
              settings: RouteSettings()),
        );
      },
      minWidth: 50, //ширина кнопки
      height: 50, //высота кнопки
      color: Colors.blue,
      textColor: Colors.red,
      child: Text(
        "--",
      ),
    );
  }


}

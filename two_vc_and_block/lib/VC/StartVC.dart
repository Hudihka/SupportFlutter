import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_vc_and_block/VC/PushVC.dart';
import 'package:two_vc_and_block/VC/PresentVC.dart';
import 'package:two_vc_and_block/bloc.dart';

class StartVC extends StatefulWidget {
  StartVC({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _StartVCState createState() => _StartVCState();
}

class _StartVCState extends State<StartVC> {
  CounterTextWidget _counterText = CounterTextWidget();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBlock>(
      create: (context) => UserBlock(StateEnum.stateNone),
      child: _startScafold(),
    );
  }


  //собств сам стартовый вк
  Scaffold _startScafold(){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _counterText,
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

class CounterTextWidget extends StatelessWidget {

  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBlock, StateEnum>(builder: (context, state) {
      if (state == StateEnum.stateAdd){
        _counter++;
        return Text(
              'Counter count $_counter',
              style: TextStyle(fontSize: 25, color: Colors.red),
            );
      } 
      
      if (state == StateEnum.stateMinus){

        if (_counter > 0) {
          _counter--;
        }

        return Text(
              'Counter count $_counter',
              style: TextStyle(fontSize: 25, color: Colors.red),
            );
      }

      return Text(
              'Counter count $_counter',
              style: TextStyle(fontSize: 25, color: Colors.red),
            );


    });
  }
}

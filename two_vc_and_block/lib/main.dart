import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Two VC and Block'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,//весь контент разделен одинак расстоянием
              children: <Widget>[
              FlatButton(onPressed: (){

              }, 
              textColor: Colors.red, 
              color: Colors.blue,
              child: Text("++",)),
              Text('Пуш ВК и ++ к счетчику')
            ]),
            SizedBox(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, //весь контент собран по центру
              children: <Widget>[
              FlatButton(onPressed: (){

              },
              minWidth: 50, //ширина кнопки
              height: 50, //высота кнопки
              color: Colors.blue, 
              textColor: Colors.red, 
              child: Text("--",)),
              Text('Пресент ВК и -- к счетчику')
            ]),
          ],
        ),
      ),
    );
  }
}


/*
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }


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
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
*/
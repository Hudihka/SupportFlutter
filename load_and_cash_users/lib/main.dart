import 'package:flutter/material.dart';

import 'ListTV.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TV Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListTV(),
    );
  }
}

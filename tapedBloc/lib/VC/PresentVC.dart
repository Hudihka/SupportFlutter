import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PresentVC extends StatelessWidget {

  Function(int) deleteTwo;

  PresentVC({@required this.deleteTwo});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Present VC'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            deleteTwo(2);
          },
          tooltip: 'Increment',
          child: Icon(
            Icons.delete,
          ),
        ));
  }
}

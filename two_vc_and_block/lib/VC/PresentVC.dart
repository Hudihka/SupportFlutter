import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_vc_and_block/bloc.dart';

class PresentVC extends StatefulWidget {
  PresentVC({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _PresentVCState createState() => _PresentVCState();
}

class _PresentVCState extends State<PresentVC> {
  @override
  Widget build(BuildContext context) {
    final UserBlock userBlock = BlocProvider.of<UserBlock>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Present VC'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //нажали отнять
            userBlock.add(Events.pressMinus);
          },
          tooltip: 'Increment',
          child: Icon(
            Icons.delete,
          ),
        ));
  }
}

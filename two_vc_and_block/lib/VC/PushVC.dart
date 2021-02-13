import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_vc_and_block/bloc.dart';



class PushVC extends StatefulWidget {
  PushVC({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _PushVCState createState() => _PushVCState();
}

class _PushVCState extends State<PushVC> {

  @override
  Widget build(BuildContext context) {

    final UserBlock userBlock = BlocProvider.of<UserBlock>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Push VC'),
        centerTitle: true,

        // обычная кнопка назад
        leadingWidth: 110,
        leading: _customButtonBackText(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          userBlock.add(Events.pressAdd);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  GestureDetector _customButtonBackText({String text}) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(children: [
        SizedBox(width: 18),
        SizedBox(
          width: 16,
          child: Icon(Icons.arrow_back_ios),
        ),
        SizedBox(
          width: 58,
          child: Center(
            child: Text(text == null ? 'Назад' : text,
                style: TextStyle(fontSize: 19)),
          ),
        )
      ]),
    );
  }

}

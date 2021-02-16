import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_vc_and_block/bloc.dart';


class PushVC extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    // final UserBlock userBlock = BlocProvider.of<UserBlock>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Push VC'),
        centerTitle: true,

        // обычная кнопка назад
        leadingWidth: 110,
        // leading: _customButtonBackText(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<UserBlock>(context).add(Events.pressAdd);
          print('-------');
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  GestureDetector _customButtonBackText({String text}) {

    // BlocProvider.of<UserBlock>(context)
    return GestureDetector(
      onTap: () {
        // Navigator.pop(context);
        // Navigator.pop(context);
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

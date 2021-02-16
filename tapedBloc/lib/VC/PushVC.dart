import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PushVC extends StatelessWidget {

  Function() tapedPlus;

   PushVC({@required this.tapedPlus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Push VC'),
        centerTitle: true,

        // обычная кнопка назад
        leadingWidth: 110,
        leading: _customButtonBackText(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          tapedPlus();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  GestureDetector _customButtonBackText(BuildContext context, {String text}) {

    return GestureDetector(
      onTap: () {
        // Navigator.of(context);
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

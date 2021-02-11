import 'package:flutter/material.dart';
//Navigator.pop(context) //возвращаемся назад
// Navigator.pop(context, 'Yep!'); //возвращаемся назад передавая данные

class PushVC extends StatefulWidget {
  PushVC({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _PushVCState createState() => _PushVCState();
}

class _PushVCState extends State<PushVC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Push VC'),
        centerTitle: true,
        //кастомная кнопка назад
        // leadingWidth: 75,
        // leading: _customButtonBack(),

        // обычная кнопка назад
        leadingWidth: 110,
        leading: _customButtonBackText(),
        //кнопки с права
        actions: _rightButtons(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //нажали добавить
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  GestureDetector _customButtonBack() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(Icons.arrow_back_ios),
    );
  }

    GestureDetector _customButtonBackText({String text}) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(children: [
        SizedBox(width: 18),
        SizedBox(width: 18, child: Icon(Icons.arrow_back_ios),),
        Text(text == null ? 'Назад' : text, style: TextStyle(fontSize: 18),)
      ]),
    );
  }

  // Icon(Icons.arrow_back_ios)

  List<Widget> _rightButtons(){
    return <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(Icons.more_vert),
              )),
        ];
  }

}

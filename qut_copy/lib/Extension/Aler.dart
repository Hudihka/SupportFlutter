import 'package:flutter/material.dart';

// class Alert {

//   showAlertDialog(BuildContext context, String title, String message, String textButton) {
//     // set up the button
//     Widget okButton = FlatButton(
//       child: Text(textButton),
//       onPressed: () {
//         this.
//       },
//     );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text(title),
//       content: Text(message),
//       actions: [
//         okButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
// }



class AlertOneButton extends StatelessWidget {

  //When creating please recheck 'context' if there is an error!

  String _title;
  String _content;
  String _yes;
  Function _yesOnPressed;

  AlertOneButton(String title, String content, Function yesOnPressed, String yes){
    this._title = title;
    this._content = content;
    this._yesOnPressed = yesOnPressed;
    this._yes = yes;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this._title),
      content: Text(this._content),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
         FlatButton(
          child:  Text(this._yes),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();//просто дисмисем
            this._yesOnPressed();
          },
        ),
      ],
    );
  }
}
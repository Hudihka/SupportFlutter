import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qut/API/Base/GetTokensRequest.dart';
import 'package:qut/API/RegisterUser.dart';
import 'package:qut/Cubits/ContentCubit.dart';
import 'package:qut/Models/Dictionary.dart';
import 'package:qut/Pages/AutorizationPage.dart';
import 'package:qut/Support/LoadWindow.dart';
import 'package:qut/Support/LogOuth/Const.dart';
import 'package:qut/Extension/String.dart';
import 'package:qut/Views/BBItem/BBItem.dart';
import 'package:qut/Views/Curtains/TagsCurtain/TagsCurtainSingelton.dart';

import '../API/Base/QUTError.dart';
import 'package:qut/API/Base/QUTError.dart';
import 'package:collection/collection.dart';




class PageTags extends StatefulWidget {

  ContentCubit contentCubit;
  final singlton = TagsCurtainSingelton.shared;

  final List<Dictionary> oldValueTags = [...TagsCurtainSingelton.shared.getListDictionary];

  List<Dictionary> listItems;

  List<Dictionary> newValueTags = [...TagsCurtainSingelton.shared.getListDictionary];
  
  PageTags({@required this.listItems, @required this.contentCubit});

  @override
  _PageTagsState createState() => _PageTagsState();
}

class _PageTagsState extends State<PageTags> {


  BuildContext _context;

  @override
  Widget build(BuildContext context) {

    _context = context;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
            shadowColor: Colors.transparent, 
            backgroundColor: Colors.white,
            actions: [
              BBItem(shadow: false, imageName: 'assets/icons/BBItem/BBItemCloseGray.png', action: (){
                Navigator.pop(context);
              })

            ]),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 0),

              child: Container (
                child: Column(children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text("Choose the categories that interest you",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Const.darkGray,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(height: 24),
                  containerTags,
                  SizedBox(height: 34),
                  _button,
                  SizedBox(height: 34), 
                ]),
              ),
            ),
          ));
  }

  List<Widget> get _generateTags {
    return widget.listItems.map((tag) => _chip(tag)).toList();
  }

    Widget get containerTags {

    return Container(
      width: double.infinity,
      height: Const.fullHeightBody - 208,
      child: SingleChildScrollView(
  child: Column(
    children: <Widget>[
      Wrap(
        alignment: WrapAlignment.start,
        spacing: 8.0, // gap between adjacent chips
        runSpacing: 0.0, // gap between lines
        children: _generateTags,
      
      )
    ],
  ),
)
    );

  }


  FilterChip _chip(Dictionary model) {
    final List<String> ids = widget.newValueTags.map((e) => e.id).toList();

    bool selected = ids.contains(model.id);

    final colorText = selected ? Colors.white : Const.darkGray;

    return FilterChip(
        showCheckmark: false,
        avatar: null,
        shape: selected ? null : StadiumBorder(side: BorderSide(color: Const.veryLightGray)),
        selected: selected,
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        backgroundColor: Colors.white,
        selectedColor: Const.darkGray,
        disabledColor: Colors.green,
        labelStyle: TextStyle(color: colorText, fontSize: 16, fontWeight: FontWeight.w400),
        label: Text(model.value), 
        onSelected: (bool value) { 
          
          if (selected) {
            widget.newValueTags.removeWhere((element) => element.id == model.id);
          } else {
            widget.newValueTags.add(model);
          }
          setState(() {});
        },);
  }


  Container get _button {

    return Container(
      width: double.infinity,
      height: 48,
      child: RaisedButton(
        color: _thereAreChanges ? Const.blue : Const.lightGray,
        child: Text('Next',
            style: TextStyle(
                color: _thereAreChanges ? Colors.white : 'F4F3F0'.getColor(),
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        onPressed: _thereAreChanges
            ? () {
                _incrementCounter();
              }
            : null,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(8.0))),
    );

  }



  void _incrementCounter() {
    widget.singlton.setNewSelectedDictionary(widget.newValueTags);
    final autoriz = AutorizationPage(logIn: false);

    autoriz.goodRequest = (){
      widget.contentCubit.fetchContent();
    };

    Navigator.push(
              _context,
              MaterialPageRoute(builder: (context) => autoriz));
  }



  //проверка изменений

  bool get _thereAreChanges {

    Function eq = const ListEquality().equals;

    if (eq(widget.newValueTags, widget.oldValueTags) == false){
      return true;
    }

    return false;
  }
}


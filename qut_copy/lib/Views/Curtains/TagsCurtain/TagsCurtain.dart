import 'package:flutter/material.dart';
import 'package:qut/API/Base/QUTError.dart';
import 'package:qut/API/DictionaryRequest/ReloadFavoritCategory.dart';
import 'package:qut/Models/Content.dart';
import 'package:qut/Models/Dictionary.dart';
import 'package:qut/Support/LoadWindow.dart';
import 'package:qut/Support/LogOuth/Const.dart';
import 'package:qut/Extension/String.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:collection/collection.dart';
import 'package:qut/Views/Curtains/TagsCurtain/TagsCurtainSingelton.dart';
import 'package:qut/Views/ShowView.dart';



class TagsCurtain extends StatefulWidget {

  final singlton = TagsCurtainSingelton.shared;

  Function cancel;
  Function newRequest;

  final List<Dictionary> oldValueTags = [...TagsCurtainSingelton.shared.getListDictionary];
  final EnumContentTupeCell oldValueType = TagsCurtainSingelton.shared.getSelectedType;

  List<Dictionary> listItems;
  bool isAutoriz;

  List<Dictionary> newValueTags = [...TagsCurtainSingelton.shared.getListDictionary];
  EnumContentTupeCell newValueType = TagsCurtainSingelton.shared.getSelectedType;
  
  TagsCurtain({@required this.listItems, @required this.isAutoriz});

  @override
  _TagsCurtainState createState() => _TagsCurtainState();
}

class _TagsCurtainState extends State<TagsCurtain> {

  BuildContext _context;

  Widget build(BuildContext context) {

    _context = context;
    return Container(
      height: _smallCurtain ? Const.hDevice * 0.8 : 638,
      color: Colors.white,
      child: _column,
    );
  }

  bool get _smallCurtain{
    return Const.hDevice < 638;
  }

  double get _heightTagsView {
    final height = _smallCurtain ? Const.hDevice * 0.8 : 638;
    return _smallCurtain ? height - 398 : 240;
  }

  Column get _column {
    return Column(
      children: [_twoButton(), _textWidget('Type'), 
                 _collectionType(), _textWidget('Category'),
                 containerTags, 
                 Spacer(),
                 _containerButton, 
                 SizedBox(height: 34,)],
    );
  }

  Widget _twoButton() {

    return Row(
      children: [
        GestureDetector(
            child: Container(
              width: 79,
              height: 40,
              child: Center(
                child: Text('Cancel',
                    style: TextStyle(
                        color: Const.devil,
                        fontSize: 15,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            onTap: () {
              widget.cancel();
            }),
        Spacer(),
        GestureDetector(
            child: Container(
              width: 98,
              height: 40,
              child: Center(
                child: Text('Clear all',
                    style: TextStyle(
                        color: _haveContent ? Const.blue : Colors.transparent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            onTap: _haveContent ? () {
              widget.newValueTags = [];
              widget.newValueType = null;
              setState(() {});
            } : null)
      ],
    );
  }

  Widget _textWidget(String text) {
    final textWidget = Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
          color: Const.darkGray, fontSize: 18, fontWeight: FontWeight.bold),
    );

    return Container(
      height: 58,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(top: 20, left: 16, bottom: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: textWidget,
          ),
        ),
      ),
    );
  }

  Widget _collectionType() {
    final dataArrayCells = [
      EnumContentTupeCell.video,
      EnumContentTupeCell.audio,
      EnumContentTupeCell.text
    ];

    return Container(
      height: 100,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: ListView.builder(
            
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: dataArrayCells.length,
            itemBuilder: (_, index) {
              final obj = dataArrayCells[index];
              return _cellTypeContent(obj == widget.newValueType, obj);
            }),
      ),
    );
  }

  Widget _cellTypeContent(bool selected, EnumContentTupeCell type) {
    final imageName = selected ? type.nameIconCellSelected : type.nameIconCellNotSelected;
    final colorText = selected ? Colors.white : Const.darkGray;

    return Padding(
      padding: EdgeInsets.only(left: 6, top: 6, right: 6, bottom: 6),
      child: GestureDetector(

          onTap: () {
      
            widget.newValueType = widget.newValueType == type ? null : type;

            setState(() {});
          },
          child: Card(
              elevation: selected ? 0 : 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),

              // elevation: selected ? 0 : 5,
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              color: selected ? Const.blue : Colors.white,
              // child: Container(height: 88, width: 88),

              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                    width: 88,
                  ),
                  Container(
                    height: 26,
                    width: 26,
                    child: Center(
                      child: Image.asset(imageName),
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 22,
                    child: Center(
                        child: Text(
                      type.textCell,
                      style: TextStyle(
                          color: colorText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                  SizedBox(height: 12)
                ],
              ))),
    );
  }


    List<Widget> get _generateTags {
    return widget.listItems.map((tag) => _chip(tag)).toList();
  }

    Widget get containerTags {

      

    return Padding(
      padding: EdgeInsets.only(left: 14, right: 14),
      child: Container(
      width: double.infinity,
      height: _heightTagsView,
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
    ));

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


  Container get _containerButton{
    return Container(
      width: double.infinity,
      height: 48,
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: _button,
      ),
    );
  }


  RaisedButton get _button {
    return RaisedButton(
        color: _thereAreChanges ? "5689C0".getColor() : "AFBAC8".getColor(),
        child: Text('Apply',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        onPressed: _thereAreChanges
            ? () {
                _tapedApply();
              }
            : null,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(8.0)));
  }

  _tapedApply(){
    widget.singlton.setNewContent(widget.newValueType, widget.newValueTags);
    if (widget.isAutoriz == false){
        widget.newRequest();
        return;
    }

    final req = ReloadFavoritCategory();
    LoadWindows.presentLoad(_context);

    req.load();

    req.endRequestListJson = ({List<dynamic> objs, QUTError error}) {
      LoadWindows.dissmisLoad(_context);
      if (error == null){
        widget.newRequest();
      } else {
        ShowView.showAlertError(error, _context);
      }
    };
  }

  //отслеживание изменений
  

  bool get _haveContent{
    if (widget.newValueType != null || widget.newValueTags.isNotEmpty){
      return true;
    }

    return false;
  }

  bool get _thereAreChanges {

    if (widget.newValueType != widget.oldValueType){
      return true;
    }

    Function eq = const ListEquality().equals;

    if (eq(widget.newValueTags, widget.oldValueTags) == false){
      return true;
    }

    return false;
  }

}




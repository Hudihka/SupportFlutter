
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:qut/Extension/Int.dart';
import 'package:qut/Extension/String.dart';
import 'package:qut/Models/Content.dart';
import 'package:qut/Pages/Complain.dart';
import 'package:qut/Support/LogOuth/Const.dart';
import 'package:qut/Support/DowloadImage.dart';
import 'package:qut/Views/Cells/CellTag.dart';
import 'package:qut/Views/Cells/ListTagsInCell.dart';
import 'package:qut/Views/Curtains/ThreeButtonCurtain.dart';
import 'package:qut/AppIcons.dart';
import 'package:share/share.dart';

class CellContent extends StatelessWidget {
  BuildContext _context;

  Content content;
  bool isAutoriz;

  Function(bool like, Content conte) tapedReaction;
  Function(Content conte) tapedCell;
  // Function(Content conte) tapedThreePoint;

  CellContent({@required this.content, @required this.isAutoriz});

  @override
  Widget build(BuildContext context) {
    _context = context;

    return GestureDetector(
      onTap: () {
        tapedCell(content);
      },
      child: isAutoriz ? Slidable(
        actions: <Widget>[
          _buttonAtCell(true),
        ],
        secondaryActions: <Widget>[
          _buttonAtCell(false),
        ],
        child: _cellForIndex(),
        actionPane: SlidableBehindActionPane(),
        key: UniqueKey(),
        dismissal: SlidableDismissal(
          child: SlidableDrawerDismissal(),
          onDismissed: (actionType) {
            tapedReaction(actionType.index == 0, content);
        },
      )
      ) : _cellForIndex(),
    );
  }

  ///КНОПКИ ПОД ЯЧЕЙКОЙ
  ///

  IconSlideAction _buttonAtCell(bool likeButton) {
    String wayImage =
        likeButton ? 'assets/icons/Heart_fill.png' : 'assets/icons/NO_fill.png';
    String text = likeButton ? 'Yes' : 'No';

    final double left = likeButton ? 27 : 0;
    final double right = likeButton ? 0 : 27;

    return IconSlideAction(
        // color: Const.clearColor,
        iconWidget: Padding(
            padding: EdgeInsets.only(left: left, right: right),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.transparent,
                  height: 26,
                  width: 26,
                  child: Image.asset(wayImage),
                ),
                SizedBox(height: 15,),
                Container(
                    color: Colors.transparent,
                    height: 19,
                    width: 50,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        text,
                        style: TextStyle(
                            color: Const.darkGray,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            )),
        onTap: () {
          tapedReaction(likeButton, content);
        });
  }


  /////////////ЯЧЕЙКА
  ///

  //вся видимая часть ячейки
  Widget _cellForIndex() {
    return Padding(
      padding: EdgeInsets.only(left: 17, top: 10, right: 17, bottom: 10),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          shadowColor: Colors.transparent,
          child: DowloadImage(content.content_preview, 192, 10, 
          content: _cellInfo(), 
          addBlure: true)
          ),
    );
  }


  Widget _cellInfo() {
    return Column(
      children: [
        _cellUppWidget(),
        Container(color: Colors.transparent, height: 74),
        _cellDownWidget(),
      ],
    );
  }

  //верхняя часть ячейки

  Widget _cellUppWidget() {
    final itsFavorite = content.favorite;
    final wDeltaCollection = itsFavorite ? 172 : 132;

    List<Widget> foundation = [
      Container(
        color: Colors.transparent,
        height: 50,
        width: 44,
        child: Padding(
            padding: EdgeInsets.only(left: 14, top: 14, right: 8, bottom: 14),
            child: Image.asset(content.type.nameIcon),
          )
      ),
      Container(
          height: 50,
          width: Const.wDevice - wDeltaCollection,
          child: Padding(
            padding: EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 10),
            child: _listTags(),
          )
          ),
      Container(
          // color: Colors.red,
          height: 50,
          width: 46,
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(10.0))),
            onPressed: () {
              _presentCurtainThreeButton();
            },
            highlightColor: Colors.white.withOpacity(0.2),
            disabledColor: Colors.white.withOpacity(0.2),
            focusColor: Colors.white.withOpacity(0.2),
            hoverColor: Colors.white.withOpacity(0.2),
            splashColor: Colors.white.withOpacity(0.2),
            child: Image.asset(AppIcons.threePoint),
          )),
    ];

    //TODO
    //Заменить потом на созданные мной
    
    if (itsFavorite) {
      final favorit = Container(
          height: 50,
          width: 40,
          child: Padding(
            padding: EdgeInsets.only(left: 0, top: 14, right: 8, bottom: 14),
            child: Image.asset("assets/icons/favorit_icon.png"),
          ));

      foundation.insert(1, favorit);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: foundation,
    );
  }

  //теги

  Widget _listTags() {
    List<String> dataArray = content.listCategory;

    return ListView.builder(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.horizontal,
        itemCount: dataArray.length,
        itemBuilder: (context, index) {
          String obj = dataArray[index];
          return CellTag(obj, Const.midleGray, Colors.white, Colors.white.withAlpha(20));
        });
  }

  //нижняя часть ячейки

  Widget _cellDownWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      // verticalDirection: VerticalDirection.up,
      children: [
        Container(
            // color: Colors.orange,
            height: 68,
            width: Const.wDevice - 103,
            child: Padding(
              padding: EdgeInsets.only(left: 16, top: 10, right: 0, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  content.name,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
        Container(
            // color: Colors.red,
            height: 68,
            width: 61,
            child: Padding(
                      padding: EdgeInsets.only(top: 29),
                      child: Text(
                content.content_qut_duration.durationContent,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
          )
            
            
            ),
      ],
    );
  }

  //Шторка

  _presentCurtainThreeButton(){
        List<String> list = ['View detail', 'Share', 'Complain'];
      final curtain = ThreeButtonCurtain(texts: list);
      curtain.actionTaped = (enumValue) {
        Navigator.pop(_context);
        if (enumValue == EnumTapedButtonCurtain.top) {
          tapedCell(content);
        } else if (enumValue == EnumTapedButtonCurtain.midle) {

          final id = content.id;
          Share.share('https://qut.media/content/$id');

        } else {

          final compl = Complain(content: content);
          Navigator.push(
        _context,
        MaterialPageRoute(
            builder: (context) => compl, fullscreenDialog: true),
      );
        }
      };

      _presentCurtain(curtain);
  }

  _presentCurtain(Widget curtain) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: _context,
        elevation: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (BuildContext bc) {
          return curtain;
        });
  }


}

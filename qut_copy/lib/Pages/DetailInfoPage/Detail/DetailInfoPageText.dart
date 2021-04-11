import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:qut/Cubits/TabBarCubit.dart';
import 'package:qut/Models/Content.dart';
import 'package:qut/Support/DowloadImage.dart';
import 'package:qut/Support/LogOuth/Const.dart';
import 'package:qut/Extension/String.dart';
import 'package:qut/Extension/Int.dart';
import 'package:qut/Views/BBItem/BBItem.dart';
import 'package:qut/Views/Cells/CellContent.dart';
import 'package:qut/Views/Cells/ListTagsInCell.dart';
import 'package:qut/Views/Cells/LoadCell.dart';
import 'package:qut/Views/MiniPlayerWidget.dart';
import 'package:share/share.dart';


class DetailInfoPageText extends StatelessWidget {

  TabBarCubit get _tabBarCubit {
    return MiniPlayerSingelton.shared.getCubit;
  }


  Content get _content {
    return _tabBarCubit.contentState.contentSelected;
  }


  bool get _isUserAutoriz {
    return _tabBarCubit.contentState.isAtorizUser;
  }

  List<Content> get _listContent {
    return _tabBarCubit.contentState.listContent;
  }


  bool get loadStatus {
    return _tabBarCubit.contentState.loadStatus;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        actions: [
          BBItem(shadow: false, imageName: 'assets/icons/BBItem/BBItemAudio.png', action: (){
            //воспроизведение аудио
          }),
          BBItem(shadow: false, imageName: 'assets/icons/BBItem/BBItemShare.png', action: (){
            final id = _content.id;
            Share.share('https://qut.media/content/$id');
          }),
          BBItem(shadow: false, imageName: 'assets/icons/BBItem/BBItemThreePoint.png', action: (){
            // DetailPageContent.curtainTwoButton(context, _content);
          }),
        ],
        leading: BBItem(shadow: false, imageName: 'assets/icons/BBItem/BBItemBack.png', action: (){ 
          _tabBarCubit.killMedia();
        }),
      ),
      body: _createTable,
      backgroundColor: Colors.white,
    );
  }


  Widget get _createTable {

      return InViewNotifierList(
  isInViewPortCondition:
      (double deltaTop, double deltaBottom, double vpHeight) {
    return deltaTop < (0.5 * vpHeight) && deltaBottom > (0.5 * vpHeight);
  },
  itemCount: _listContent.length + 1,
  builder: (BuildContext context, int index) {
    return InViewNotifierWidget(
      id: '$index',
      builder: (BuildContext context, bool isInView, Widget child) {

        if (isInView){
               _tabBarCubit.loadPagin(index);
        }

        if (index == 0){
          return _hederTable;
        } else {
          final content = _listContent[index - 1];

          switch (content.typeCell) {
              case EnumTupeCell.content:
                  final cell = CellContent(content: content, isAutoriz: _isUserAutoriz,);

                  cell.tapedCell = (obj){
                    _tabBarCubit.openFullScreen(obj);
                  };

                  return cell;
              default :
                return LoadCell();
            }

        }
        
      },
    );
  },
);


  }



  Container get _hederTable {
    return Container(
      child: Column(children: [_audioPlauer(), _containerText()],),
      width: double.infinity,
    );
  }

  Container _audioPlauer() {
    final duration = _content.content_qut_duration.durationContent;

    return Container(
      // height: Const.heightVideo,
      width: double.infinity,
      child: Stack(children: [
        Container(
          color: Colors.black,
          width: double.infinity,
          child: DowloadImage(_content.content_preview, Const.heightVideo, 0),
        ),

        Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: 13, top: 10, right: 0, bottom: 10),
                child: _listTags(),
          )
        ),
        SizedBox(height: 16,),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 0 , right: 16, bottom: 0),
          child: Container(
                width: double.infinity,
                height: 56,
                child: Text(_content.name, textAlign: TextAlign.left, maxLines: 2,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
              )
        )
          ]
        ),

        Container(
          height: Const.heightVideo,
          width: 150,
          color: Colors.transparent,
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.only(left: 16, bottom: 20),
          child: Text('Reading time $duration', 
                      textAlign: TextAlign.left,
                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),),
        )

      ]
    )
    );
  }
  

  Container _containerText(){

    return Container(
      width: double.infinity,
      child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 24),
                  child: Text(_content.text_qut, 
                  style: TextStyle(color: Const.darkGray, fontSize: 16, fontWeight: FontWeight.w400),),
                )
    );
  }


  //теги

  Widget _listTags() {
    List<String> dataArray = _content.listCategory;

    return ListTagsInCell(dataArray, 
        "CED6E9".getColor(),
        Colors.white, Colors.white.withAlpha(20));
  }

}

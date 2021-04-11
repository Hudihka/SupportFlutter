import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:qut/Cubits/TabBarCubit.dart';
import 'package:qut/Models/Content.dart';
import 'package:qut/Support/LogOuth/Const.dart';
import 'package:qut/Views/BBItem/BBItem.dart';
import 'package:qut/Views/Cells/CellContent.dart';
import 'package:qut/Views/Cells/HederMultimedia.dart';
import 'package:qut/Views/Cells/LoadCell.dart';
import 'package:qut/Views/MiniPlayerWidget.dart';
import 'package:qut/Views/ShowView.dart';
import 'package:share/share.dart';

class DetailInfoPageMedia extends StatelessWidget {

  Widget widgetMedia;
  HederMultimedia heder;

  DetailInfoPageMedia({@required this.widgetMedia});

  TabBarCubit get _tabBarCubit {
    return MiniPlayerSingelton.shared.getCubit;
  }

  Content get _content {
    return _tabBarCubit.contentState.contentSelected;
  }

  // GlobalKey get _keyHeder {
  //   return _tabBarCubit.contentState.keyHeder;
  // }

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

    return WillPopScope(
      onWillPop: () { 
        _tabBarCubit.openMiniMedia();
       },
      child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        actions: [
          BBItem(
              shadow: false,
              imageName: 'assets/icons/BBItem/BBItemBook.png',
              action: () {
                _tabBarCubit.getTextDetail(context);

              }),
          BBItem(
              shadow: false,
              imageName: 'assets/icons/BBItem/BBItemShare.png',
              action: () {
                final id = _content.id;
                Share.share('https://qut.media/content/$id');
              }),
          BBItem(
              shadow: false,
              imageName: 'assets/icons/BBItem/BBItemThreePoint.png',
              action: () {
                ShowView.curtainTwoButton(context, _content);
              }),
        ],
        leading: BBItem(
            shadow: false,
            imageName: 'assets/icons/BBItem/BBItemBack.png',
            action: () {
              _tabBarCubit.openMiniMedia();
            }),
      ),
      body: _allContent(),
      backgroundColor: Colors.white,
    )
  );
  }


  Widget _allContent() {
    return Column(children: [
      _videoPlauer(),
      Container(
          height: Const.fullHeightBody - Const.heightVideo,
          width: double.infinity,
          color: Colors.white,
          child: _createTable()
          )
    ]);
  }

  //ВИдео

    Container _videoPlauer() {

    return Container(
      height: Const.heightVideo,
      width: double.infinity,
      color: Colors.black,
      child: widgetMedia,
    );
  }


  //ТАБЛИЦА

  Widget _createTable() {

    if (loadStatus){
      if (_listContent.isEmpty){
        return Center(
          child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Const.darkGray),
                    ),
        );
      }
    }



    return InViewNotifierList(isInViewPortCondition: (double deltaTop, double deltaBottom, double vpHeight) {
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

            return _cellForIndex(index);

          },
        );
      },
    );
  }

  Widget _cellForIndex(int index){

    if (index == 0){
      return HederMultimedia();
    }

    Content obj = _listContent[index - 1];

            switch (obj.typeCell) {
              case EnumTupeCell.content:
                return _cellContent(obj);
              default :
                return LoadCell();
            }
  }



  CellContent _cellContent(Content obj) {
    CellContent cell = CellContent(content: obj, isAutoriz: _isUserAutoriz);

    cell.tapedCell = (Content conte) {
       _tabBarCubit.openFullScreen(conte);
    };


    return cell;
  }





}

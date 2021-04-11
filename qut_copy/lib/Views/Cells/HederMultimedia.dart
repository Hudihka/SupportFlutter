import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:qut/Cubits/TabBarCubit.dart';
import 'package:qut/Models/Content.dart';
import 'package:qut/Support/LogOuth/Const.dart';
import 'package:qut/Extension/String.dart';
import 'package:qut/Views/Cells/ListTagsInCell.dart';
import 'package:qut/Views/MiniPlayerWidget.dart';


class HederMultimedia extends StatelessWidget {


  TabBarCubit get _tabBarCubit {
    return MiniPlayerSingelton.shared.getCubit;
  }

  Content get _content {
    return _tabBarCubit.contentState.contentSelected;
  }

  bool get _isUserAutoriz {
    return _tabBarCubit.contentState.isAtorizUser;
  }


  bool get loadStatus {
    return _tabBarCubit.contentState.loadStatus;
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      child: _allContentHeder(),
      height: 116,
      width: double.infinity,
      color: Colors.white,
    );
  }


  Column _allContentHeder() {

    return Column(
      children: [_tagsList, _nameAndButton()],
    );
  }



  Container get _tagsList {
    return Container(
        height: 52,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(left: 16, top: 15, right: 0, bottom: 7),
          child: _listTags(),
        ));
  }
 
  Row _nameAndButton() {
    final imageName = _content.favorite
        ? 'assets/icons/Heart_fill.png'
        : 'assets/icons/likeBlackButton.png';
    final wTewt = _isUserAutoriz ? Const.wDevice - 100 : Const.wDevice;

    List<Widget> nameWidget = [
      Container(
          height: 64,
          width: wTewt,
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 0, right: 16, bottom: 20),
            child: Text(
              _content.name,
              style: TextStyle(
                  color: Const.darkGray,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          )),
    ];

    if (_isUserAutoriz) {
      final listDop = [
        SizedBox(width: 16),
        Container(
            height: 26,
            width: 26,
            alignment: Alignment.topCenter,
            child: GestureDetector(
                onTap: () {
                  print('huhfuyf');
                },
                child: Image.asset('assets/icons/dissLikeBlackButton.png'))),
        SizedBox(width: 16),
        Container(
            alignment: Alignment.topCenter,
            height: 26,
            width: 26,
            child: GestureDetector(
                onTap: () {
                  print('huhfuyf');
                },
                child: Image.asset(imageName))),
        SizedBox(width: 16),
      ];
      nameWidget = nameWidget + listDop;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: nameWidget,
    );
  }

  //теги

  Widget _listTags() {
    List<String> dataArray = _content.listCategory;

    return ListTagsInCell(
        dataArray, Colors.transparent, Const.darkGray, 'F2F4F6'.getColor());
  }

}

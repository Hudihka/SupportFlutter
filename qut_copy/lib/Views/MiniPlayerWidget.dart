

import 'package:flutter/material.dart';
import 'package:qut/Cubits/TabBarCubit.dart';
import 'package:qut/Models/Content.dart';
import 'package:qut/Pages/LentaPage.dart';
import 'package:qut/Support/DowloadImage.dart';
import 'package:qut/Support/LogOuth/Const.dart';
import 'package:qut/Support/MediaContent/PlayerWidget.dart';


class MiniPlayerSingelton{

  MiniPlayerSingelton._();
  static final MiniPlayerSingelton shared = MiniPlayerSingelton._();

  bool _playStatus = false;

  TabBarCubit _contentCubit;


  bool get getPlayStatus{
    return _playStatus;
  }

  savePlayStatus(bool valye){
    _playStatus = valye;
  }

  //Cubit 

  saveCubit(TabBarCubit cubit){
    if (cubit != null) {
      _contentCubit = cubit;
    }
  }

  TabBarCubit get getCubit {
    return _contentCubit;
  }
}



class MiniPlayerWidget extends StatelessWidget {

  PlayerWidget widgetContent;

  // Content content;
  MiniPlayerWidget({@required this.widgetContent});

  TabBarCubit get _tabBarCubit {
    return MiniPlayerSingelton.shared.getCubit;
  }

  Content get _content {
    return _tabBarCubit.state.contentSelected;
  }               


  @override
  Widget build(BuildContext context) {

    return Container(

      color: Colors.white,
      height: 60,
      width: Const.wDevice,
      child: Column(
        children: [
          SizedBox(height: 8),
          _fondationWidget,
          SizedBox(height: 8),
        ],
      ),

    );
  }

  Widget get _fondationWidget {
    Stack stack = Stack(
      children: [
        widgetContent,
        GestureDetector(
          onTap: (){
            _tabBarCubit.openFullScreen(_content);
          },
          child: Container(
            height: 44,
            width: Const.wDevice - 116,
            color: Colors.transparent,
            alignment: Alignment.centerLeft,
          ),
        )
      ]
    );



    return Row(
      children: [
        SizedBox(width: 16,),
        stack,
        // widgetContent,
        _buttonClose ,
        SizedBox(width: 8,),
      ]
    );
  }


  Widget get _buttonClose {
      return Container(
        width: 40,
        height: 40,

        child: Container(
          width: 26,
          height: 26,

              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: TextButton(
          onPressed: (){
            _tabBarCubit.killMedia();
          },
          child: Image.asset('assets/icons/audioPlayer/close.png')),
    )
              ),
            ),
    );
  }


}

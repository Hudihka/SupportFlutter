import 'dart:async';
import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qut/API/GetContentText.dart';
import 'package:qut/Models/Content.dart';
import 'package:qut/Pages/DetailInfoPage/DetailText.dart';
import 'package:qut/Support/LoadWindow.dart';
import 'package:qut/Support/LogOuth/Const.dart';
import 'package:qut/Support/LogOuth/DefaultUtils.dart';

import 'package:qut/API/Base/QUTError.dart';
import 'package:qut/API/GetContentRequest.dart';
import 'package:qut/Views/MiniPlayerWidget.dart';


enum EnumTabBar {
  fullScreen, //показываем во весь экран
  miniMedia, //показываем мини ввидео
  emptyContent, //просто таб бар
  horizontalScreen //окно во весь экран
}

extension SizeIndex on EnumTabBar {

  double get heightTabBar {
    switch(this) {
      case EnumTabBar.fullScreen: return Const.hDevice - Const.statusBarHeight;
      case EnumTabBar.horizontalScreen: return Const.hDevice - Const.statusBarHeight;
      case EnumTabBar.miniMedia: return 135;
      case EnumTabBar.emptyContent: return 75;
    }
  }
}

class TabBarState {
  // Widget content;

  Content contentSelected;
  EnumTabBar enumType;
  int selectedIntdex;
  bool isAtorizUser;
  bool loadStatus;
  GlobalKey key;


  List<Content> listContent;
  Content contentDetail;
  QUTError error;


  TabBarState({this.contentSelected,
              this.enumType,
              this.isAtorizUser,
              this.selectedIntdex,
              this.listContent,
              this.loadStatus,
              this.contentDetail,
              this.key,
              this.error});

  TabBarState copyWith({Content newContentSelected,
                        EnumTabBar newEnumType,
                        bool newIsAtorizUser,
                        int newSelectedIntdex, 
                        List<Content> newListContent,
                        bool newLoadStatus,
                        Content newContentDetail,
                        QUTError newError,
                        GlobalKey newKey,}) {


    if (newSelectedIntdex != null) {
      this.selectedIntdex = newSelectedIntdex;
    }

    
    if (newContentSelected != null){
      this.contentSelected = newContentSelected;
    }

    if (newEnumType != null){
      this.enumType = newEnumType;
    }

    if (newIsAtorizUser != null){
      this.isAtorizUser = newIsAtorizUser;
    }

    if (newListContent != null){
      this.listContent = newListContent;
    }

    if (newLoadStatus != null){
      this.loadStatus = newLoadStatus;
    }

    if (newKey != null){
      this.key = newKey;
    }

    if (newContentDetail != null){
      this.contentDetail = newContentDetail;
    }

    this.error = newError;

    return TabBarState(
        contentSelected: newContentSelected ?? this.contentSelected,
        enumType: newEnumType ?? this.enumType,
        isAtorizUser: newIsAtorizUser ?? this.isAtorizUser,
        selectedIntdex: newSelectedIntdex ?? this.selectedIntdex,
        listContent: newListContent ?? this.listContent,
        loadStatus: newLoadStatus ?? this.loadStatus,
        contentDetail: newContentDetail ?? this.contentDetail,
        error: this.error,
        key: newKey ?? this.key,
      );
  }
}

class TabBarCubit extends Cubit<TabBarState> {

  List<Content> _listContent = [];
  int _countAll = 0;
  Content _selctedContent;
  bool _loadStaus;
  GlobalKey _key;
  Content _contentDetail;


  final TabBarState contentState;

  TabBarCubit(this.contentState) : super(TabBarState());

  fetchContent(Content content) {
    emit(contentState.copyWith(newContentSelected: content));
  }

  openFullScreen(Content content) async {

    _contentDetail = null;
    _generateData(content);

    final isAutoriz = await DefaultUtils.shared.autorizUser;

    _listContent = [Content(typeCell: EnumTupeCell.load)];

    emit(contentState.copyWith(newListContent: _listContent, 
                               newLoadStatus: _loadStaus, 
                               newContentSelected: _selctedContent,
                               newIsAtorizUser: isAutoriz,
                               newEnumType: EnumTabBar.fullScreen,
                               newKey: _key,
                              //  newKeyHeder: _keyHeder
                               ));

    final request = GetContentRequest(type: content.type);
    request.load();

    request.endRequestJson = ({dynamic obj, QUTError error}) async {

      _loadStaus = false;

      if (error == null) {

        List<Content> objs = obj['data'] ?? [];
        _countAll = obj['total'] ?? 0;

        if (_countAll != 0){
          _countAll = _countAll - 1;
        }

        _listContent = objs;
        _listContent.removeWhere((element) => element.id == _selctedContent.id);

        emit(contentState.copyWith(newListContent: _listContent, newLoadStatus: _loadStaus));
      } else {
        emit(contentState.copyWith(newListContent: _listContent, newLoadStatus: _loadStaus, newError: error));
      }
   };

}

//ГЕНЕРИМ КЛЮЧ И ПРОЧЕЕ В ЗАВИСИМОСТИ ОТ ТОГО ЕСТЬ У НАС УЖЕ ВОСПР ЧТО НИБУДЬ ИЛИ НЕТ

_generateData(Content content){
    _countAll = 0;
    _listContent = [];
    _loadStaus = true;
    
    //значит что только начали воспроизведение
    if (_selctedContent == null){
      _key = GlobalKey();
      // _keyHeder = GlobalKey();
      _selctedContent = content;
    } if (content.id != _selctedContent.id){ //выбрали новый контент

      if (content.type == EnumContentTupeCell.audio){
        AudioService.stop();
        AudioService.connect();
      }

      MiniPlayerSingelton.shared.savePlayStatus(false);
      _selctedContent = content;
      _key = GlobalKey();



    }
    //иначе просто нажатие на мини вью

}

  openHorizontalWindows() {
    emit(contentState.copyWith(newEnumType: EnumTabBar.horizontalScreen));
  }

  dismisHorizontalWindows() {
    emit(contentState.copyWith(newEnumType: EnumTabBar.fullScreen));
  }

  openMiniMedia() {
    if (MiniPlayerSingelton.shared.getPlayStatus){
      emit(contentState.copyWith(newEnumType: EnumTabBar.miniMedia));
    } else {
      killMedia();
    }
  }

  killMedia() {
    MiniPlayerSingelton.shared.savePlayStatus(false);
   _listContent = [];
   _contentDetail = null;
   _countAll = 0;
   _selctedContent = null;
   _loadStaus = false;
    _key = null;
    AudioService.stop();
    emit(contentState.copyWith(newEnumType: EnumTabBar.emptyContent));
  }


  newSelectedIndex(int index) {
 
    _contentDetail = null;
    emit(contentState.copyWith(newSelectedIntdex: index));
  }



  ///пагинация
  loadPagin(int index){
    if (_loadStaus) {
      return;
    }

    if (_listContent.length < 12){ //чисто для первой страницы
      if (index >= _listContent.length - 10){
        _loadContent();
      }
    } else if (index >= _listContent.length - 8){
        _loadContent();
    }

  }

  _loadCell({@required bool load}){
    _loadStaus = load;
    if (load){
      _listContent.add(Content(typeCell: EnumTupeCell.load));
      emit(contentState.copyWith(newListContent: _listContent, newLoadStatus: _loadStaus));
    } else {
      _listContent.removeWhere((element) => element.typeCell == EnumTupeCell.load);
      emit(contentState.copyWith(newLoadStatus: _loadStaus));
    }

  }


  _loadContent(){
    
    final int modelsContent = _listContent.length + 1;

    if (modelsContent >= _countAll) {
      //загрузили все что можно
      emit(contentState.copyWith(newLoadStatus: false));
      return;
    }

    if (modelsContent < 10) {
      //всего 1 лист
      emit(contentState.copyWith(newLoadStatus: false));
      return;
    }

  _loadCell(load: true);


  int page = 1 + (modelsContent ~/ 10);
  final request = GetContentRequest(page: page, type: _selctedContent.type);

  request.load();

  request.endRequestJson = ({dynamic obj, QUTError error}) async {
    _loadCell(load: false);
      if (error == null) {

        List<Content> objs = obj['data'] ?? [];
        _countAll = obj['total'] ?? 0;
        
        _listContent = _listContent + objs;
        emit(contentState.copyWith(newListContent: _listContent, newLoadStatus: false));
      } else {
        emit(contentState.copyWith(newLoadStatus: false, newError: error));
      }
   };


  }

  //детальная информация
  //
  
  getTextDetail(BuildContext context){

    if (_contentDetail != null){
      return;
    }

    LoadWindows.presentLoad(context);

    final req = GetContentText(id: _selctedContent.id);

    req.load();

    req.endRequestJson = ({dynamic obj, QUTError error}) async {

      LoadWindows.dissmisLoad(context);

      if (error == null) {

        _contentDetail = obj;
        final textVC = DetailText(content: _contentDetail,);

        Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => textVC, fullscreenDialog: true),
                );

      } else {
        emit(contentState.copyWith(newError: error));
      }
   };


  }


  MediaItem get _getNewSong {

    return MediaItem(
      id: _selctedContent.content_link,
      album: "name",
      title: "QUT",
      artist: _selctedContent.name,
      duration: Duration(seconds: _selctedContent.content_qut_duration),
      artUri: Uri.parse(_selctedContent.content_preview),
    );

  }



}
 
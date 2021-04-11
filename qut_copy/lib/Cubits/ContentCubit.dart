import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qut/API/Base/QUTError.dart';
import 'package:qut/API/GetContentRequest.dart';
import 'package:qut/API/ReactionRequest.dart';
import 'package:qut/Models/Content.dart';
import 'package:qut/Models/Dictionary.dart';

import 'package:qut/Support/LoadWindow.dart';
import 'package:qut/Support/LogOuth/DefaultUtils.dart';
import 'package:qut/Views/Curtains/TagsCurtain/TagsCurtainSingelton.dart';

class ContentState {
  bool loadStatus;
  bool isAtorizUser;
  List<Content> listContent;
  QUTError errorBackend;


  int allCount;


  ContentState({this.loadStatus, 
                this.listContent, 
                this.errorBackend, 
                this.isAtorizUser, 
                this.allCount});

  ContentState copyWith({bool newLoadStatus, 
                         List<Content> newListContent, 
                         QUTError newErrorBackend, 
                         bool newIsAutoriz,
                         int newAllCount}) {

    if (newLoadStatus != null){
      this.loadStatus = newLoadStatus;
    }

    if (newListContent != null){
      this.listContent = newListContent;
    }

    if (newIsAutoriz != null){
      this.isAtorizUser = newIsAutoriz;
    }

    if (newAllCount != null){
      this.allCount = newAllCount;
    }


    return ContentState(
        loadStatus: newLoadStatus ?? this.loadStatus,
        listContent: newListContent ?? this.listContent,
        errorBackend: newErrorBackend ?? this.errorBackend,
        isAtorizUser: newIsAutoriz ?? this.isAtorizUser,
        allCount: newAllCount ?? this.allCount);
  }
}

class ContentCubit extends Cubit<ContentState> {
  List<Content> _listContent = [];
  QUTError errorBackend;

  int _countAll = 0;

  final ContentState contentState;
  ContentCubit(this.contentState) : super(ContentState());

  Future<void> fetchContent() async {

    emit(contentState.copyWith(newListContent: _listContent, newLoadStatus: true, newIsAutoriz: false));

    //показываем в начале пустой экран
    final isAutoriz = await DefaultUtils.shared.autorizUser;
    ///
    emit(contentState.copyWith(newListContent: _listContent, newLoadStatus: true, newIsAutoriz: isAutoriz));

    final request = GetContentRequest();
    request.load();

    request.endRequestJson = ({dynamic obj, QUTError error}) async {
      if (error == null) {

        List<Content> objs = obj['data'] ?? [];
        _countAll = obj['total'] ?? 0;

        _listContent = objs;      
        
        await _reloadList();
        emit(contentState.copyWith(newListContent: _listContent, newLoadStatus: false, newAllCount: _countAll));
      } else {
        emit(contentState.copyWith(newListContent: _listContent, newLoadStatus: false, newErrorBackend: error));
      }
   };

  }

  //Функция срабатывает если узер зарегистрировался или наоборот произощел логаут

  Future<void> cleraContentAndLoad() async {
    _listContent = [];
    _countAll = 0;
    await fetchContent();
  }

  Future<void> reaction(Content content, bool like) {

    final request = ReactionRequest(content.id, like);
    request.load();

    int index = _listContent.indexWhere((element) => element.id == content.id);

    if (index != null){
      _listContent.removeAt(index);

      if (like == true){
        _listContent.insert(index, content);
      } 
      
      emit(contentState.copyWith(newListContent: _listContent, newLoadStatus: true));
    }
    

    request.endRequestJson = ({dynamic obj, QUTError error}) {

      if (error != null) {
        emit(contentState.copyWith(newListContent: _listContent, newLoadStatus: false, newErrorBackend: error));
      } else {

        if (like == false){
          // emit(contentState.copyWith(listContent: _listContent, loadStatus: false));
          return;
        }

        Content newContent = obj as Content;
        if (index != null) {
          _listContent[index] = newContent;
          emit(contentState.copyWith(newListContent: _listContent, newLoadStatus: false));
        }

      }
    };
  }


  //здесь мы редактируем массив контента в зависимости от статуса, есть юзер или нет итд

  Future _reloadList() async {


    if (_listContent.length > 0){
      _listContent.insert(0, Content(typeCell: EnumTupeCell.empty));
    }

    final isAutoriz = await DefaultUtils.shared.autorizUser;
    
    if (isAutoriz == false){

      if (_listContent.length > 9){
        _listContent.insert(8, Content(typeCell: EnumTupeCell.tags));
      }

      if (_itsAllLengContent >= _countAll){
        if (_listContent.length > 0){
        _listContent.add(Content(typeCell: EnumTupeCell.registration));
        }
      }
    }


  }

  Future _addRegistrationCell() async {
    final isAutoriz = await DefaultUtils.shared.autorizUser;
    
    if (isAutoriz == false){
      if (_itsAllLengContent >= _countAll){
        _listContent.add(Content(typeCell: EnumTupeCell.registration));
      }
    }
  }



  int get _itsAllLengContent {
    int modelsContent = _listContent.where((e) => e.typeCell == EnumTupeCell.content).toList().length;
    return modelsContent;
  }

  _loadCell({@required bool load}){
    if (load){
      _listContent.add(Content(typeCell: EnumTupeCell.load));
      emit(contentState.copyWith(newListContent: _listContent));
    } else {
      _listContent.removeWhere((element) => element.typeCell == EnumTupeCell.load);
    }

  }

  //дозагрузка и пагинация

  loadContent({bool favorite}){

    emit(contentState.copyWith(newLoadStatus: true));

    
    final int modelsContent = _itsAllLengContent;

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
  final request = GetContentRequest(page: page);

  request.load();

  request.endRequestJson = ({dynamic obj, QUTError error}) async {
      if (error == null) {

        List<Content> objs = obj['data'] ?? [];
        _countAll = obj['total'] ?? 0;

        _loadCell(load: false);
        
        _listContent = _listContent + objs;
        await _addRegistrationCell();
        emit(contentState.copyWith(newListContent: _listContent, newLoadStatus: false, newAllCount: _countAll));
      } else {
        emit(contentState.copyWith(newLoadStatus: false, newErrorBackend: error));
      }
   };


  }

}

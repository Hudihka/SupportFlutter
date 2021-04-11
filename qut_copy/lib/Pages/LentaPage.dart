import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qut/API/Base/QUTError.dart';
import 'package:qut/API/DictionaryRequest/GetDictionariesSlug.dart';
import 'package:qut/Cubits/ContentCubit.dart';
import 'package:qut/Cubits/TabBarCubit.dart';
import 'package:qut/Extension/Aler.dart';
import 'package:qut/Models/Content.dart';
import 'package:qut/Models/Dictionary.dart';
import 'package:qut/Pages/AutorizationPage.dart';
import 'package:qut/Pages/PageTags.dart';
import 'package:qut/Support/LoadWindow.dart';
import 'package:qut/Support/LogOuth/Const.dart';
import 'package:qut/Views/Cells/LoadCell.dart';
import 'package:qut/Views/Curtains/TagsCurtain/TagsCurtainSingelton.dart';
import 'package:qut/Views/ShowView.dart';
import 'package:share/share.dart';
import 'package:qut/Views/BBItem/BBItem.dart';
import 'package:qut/Views/Cells/CellContent.dart';
import 'package:qut/Views/Cells/ChooseCategogyCell.dart';
import 'package:qut/Views/Cells/EmptyCell.dart';
import 'package:qut/Views/Cells/RegistrationCell.dart';
import 'package:qut/Views/Curtains/TagsCurtain/TagsCurtain.dart';
import 'package:qut/Views/Curtains/ThreeButtonCurtain.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:qut/Views/MiniPlayerWidget.dart';

class LentaPage extends StatelessWidget {
  final contentState = ContentState();

  @override
  Widget build(BuildContext context) {
    return Lenta();
  }
}

class Lenta extends StatelessWidget {

  BuildContext _context;
  ContentCubit _contentCubit;
  List<Content> _dataArray = [];
  bool _loadStatus = true;
  bool _isAutoriz = false;

  bool addLineStatusBar;


  @override
  Widget build(BuildContext context) {
    //говорит о том, что грузим юзеров при запуске
    _context = context;
    _contentCubit = context.read();

    return BlocConsumer<ContentCubit, ContentState>(builder: (context, state) {
      if (state is ContentState) {

        _dataArray = state.listContent ?? [];
        _loadStatus = state.loadStatus;
        _isAutoriz = state.isAtorizUser ?? false;

        if (_dataArray.isEmpty) {
          return _scafoldLoad;
        } else {
          return _createScafold();
        }

      }

      return SizedBox();
    }, listener: (context, state){
      if (state is ContentState) {
        QUTError _error = state.errorBackend;

        if (_error != null) {
          ShowView.showAlertError(_error, _context);
        }

      }
    });
  }

  Scaffold get _scafoldLoad {

    final content = _loadStatus ? Center(
          child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Const.darkGray),
                    ),
        ) : _emptyBack;

    final body = _contentWidget(content: content, addButton: !_loadStatus, );

    return Scaffold(
        backgroundColor: Colors.white,
        body: body,
      );
  }

  Scaffold _createScafold() {
    return Scaffold(
        backgroundColor: Colors.white,
        body: _contentWidget(content: _createTable(), addButton: true),
      );
  }

  Widget get _emptyBack {
    return Center(
      child: Text('на бэке пусто, я не знаю что отображать в такой ситуации. Но можешь убрать фильтры'),
    );
  }


  Stack _contentWidget({@required Widget content, 
                        @required bool addButton}){
    List<Widget> listVidget = [content];


    if (addButton){

      final button = Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: Const.statusBarHeight, right: 10, bottom: 0),
            child: Container(
              height: 50,
              width: 50,
              child: BBItem(shadow: true, imageName: 'assets/icons/BBItem/BBItemFilter.png', action: (){

                _requestTags(true);

            }),
            ),

          ),
        );

      listVidget.add(button);

    }


  // //если мы делаем статус бар во весь экран
  // //появляется противная прозрачная полоска
  // //я не знаю как ее правильно фиксануть
  // //поэтому просто на основе этой переменной рисуем белый контейнер в самом верху

  //   final type = MiniPlayerSingelton.shared.getCubit.state.enumType;

  //   if (type == EnumTabBar.fullScreen || type == EnumTabBar.horizontalScreen){
  //     final statusBar = Container(
  //       width: double.infinity,
  //       height: 50,
  //       color: type == EnumTabBar.horizontalScreen ? Colors.black : Colors.white,
  //       alignment: Alignment.topCenter,
  //     );
  //     listVidget.add(statusBar);

  //   }

    return Stack(children: listVidget);
  }

  Widget _createTable() {

    return InViewNotifierList(
  isInViewPortCondition:
      (double deltaTop, double deltaBottom, double vpHeight) {
    return deltaTop < (0.5 * vpHeight) && deltaBottom > (0.5 * vpHeight);
  },
  itemCount: _dataArray.length,
  builder: (BuildContext context, int index) {
    return InViewNotifierWidget(
      id: '$index',
      builder: (BuildContext context, bool isInView, Widget child) {
        //алгоритм старта пагинации

        _loadPagin(index, isInView);

        Content obj = _dataArray[index];

            switch (obj.typeCell) {
              case EnumTupeCell.content:
                return _cellContent(obj);
              case EnumTupeCell.empty:
                return EmptyCell();
              case EnumTupeCell.registration:
                return _cellRegistration();
              case EnumTupeCell.tags:
                return _categoruCell();
              case EnumTupeCell.load:
                return LoadCell();
            }


      },
    );
  },
);

  }


  _tapedRegistaration(){

    final cell = RegistrationCell();
    final autPage = AutorizationPage(logIn: false,);
    autPage.goodRequest = () {
      _contentCubit.cleraContentAndLoad();
    };
    Navigator.push(
        _context,
        MaterialPageRoute(
            builder: (context) => autPage, fullscreenDialog: true),
      );


  }


  //ЯЧЕЙКА ПО ИНДЕКСУ

  RegistrationCell _cellRegistration() {
    final cell = RegistrationCell();
    cell.tapedRegistration = (){
      _tapedRegistaration();
    };
    return cell;
  }

  ChooseCategogyCell _categoruCell() {
    final cell = ChooseCategogyCell();
    cell.tapedCategorus = () {
      _requestTags(false);
    };

    return cell;
  }

  CellContent _cellContent(Content obj) {
    CellContent cell = CellContent(content: obj, isAutoriz: _isAutoriz);

    cell.tapedReaction = (bool like, Content conte) {
      _pressButtonOnCell(conte, like);
    };

    cell.tapedCell = (Content conte) {
      // _tapedRegistaration();
      MiniPlayerSingelton.shared.getCubit.openFullScreen(conte);
    };

    return cell;
  }




  _pressButtonOnCell(Content obj, bool pressLike) {
    if (_loadStatus) {
      return;
    }

    _contentCubit.reaction(obj, pressLike);
  }



  //ПАГИНАЦИЯ

  _loadPagin(int index, bool isVisible){
    if (_loadStatus) {
      return;
    }

    if (isVisible == false){
      return;
    }


    if (_dataArray.length < 13){ //чисто для первой страницы
      if (index >= _dataArray.length - 10){
        _contentCubit.loadContent();
      }
    } else if (index >= _dataArray.length - 8){
        _contentCubit.loadContent();
    }

  }

  //показ тегов
  
  _requestTags(bool showCurtain){
      if (_loadStatus){
                    return;
              }

    LoadWindows.presentLoad(_context);

    final request = GetDictionariesSlug(slug: 'category');
    request.load();

    request.endRequestListJson = ({List<dynamic> objs, QUTError error}) {

      LoadWindows.dissmisLoad(_context);
      
      if (error != null) {
        ShowView.showAlertError(error, _context);
      } else if (objs.isNotEmpty) {

        if (showCurtain){
        _blureAndCurtain(objs);
        } else {
          _popTagsScafold(objs);
        }
      }

    };

  }

  _popTagsScafold(List<Dictionary> listItems){
      final textTags = PageTags(listItems: listItems, contentCubit: _contentCubit,);

        Navigator.push(_context,
                  MaterialPageRoute(
                      builder: (context) => textTags, fullscreenDialog: true),
        );

  }


  _blureAndCurtain(List<Dictionary> listItems){

    if (listItems.isNotEmpty){
      // TagsCurtain
        final curtain = TagsCurtain(listItems: listItems, isAutoriz: _isAutoriz,);

        curtain.cancel = (){
          Navigator.pop(_context);
        };

        curtain.newRequest = (){
          Navigator.pop(_context);
          _contentCubit.cleraContentAndLoad();
        };

        ShowView.presentCurtain(curtain, _context);
    }
  }



}



  //загрузка тегов

  // Future loadTags(BuildContext context) async {

  //   LoadWindows.presentLoad(context);

  //   final request = GetDictionariesSlug(slug: 'category');
  //   request.load();

  //   request.endRequestListJson = ({List<dynamic> objs, QUTError error}) {

  //     LoadWindows.dissmisLoad(context);
      
  //     if (error != null) {
  //       emit(contentState.copyWith(newErrorBackend: errorBackend));
  //     } else {
  //       emit(contentState.copyWith(newListDictionary: objs));
  //     }

  //   };

  // }


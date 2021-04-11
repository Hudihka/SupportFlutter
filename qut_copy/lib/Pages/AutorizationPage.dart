import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qut/API/Base/GetTokensRequest.dart';
import 'package:qut/API/DictionaryRequest/ReloadFavoritCategory.dart';
import 'package:qut/API/RegisterUser.dart';
import 'package:qut/Support/LoadWindow.dart';
import 'package:qut/Support/LogOuth/Const.dart';
import 'package:qut/Extension/String.dart';
import 'package:qut/Views/BBItem/BBItem.dart';
import 'package:qut/Views/Curtains/TagsCurtain/TagsCurtainSingelton.dart';

import '../API/Base/QUTError.dart';

class AutorizationPage extends StatefulWidget {
  Function goodRequest;
  bool logIn;
  //bool twoPop; //необходимость сделать двожды попВК, в случае когда мы в начале выбираем теги, а потом пегистрируемся
  AutorizationPage({Key key, @required this.logIn}) : super(key: key);

  @override
  _AutorizationPageState createState() => _AutorizationPageState();
}

class _AutorizationPageState extends State<AutorizationPage> {
  String _login = "";
  String _password = "";
  QUTError _error;

  BuildContext _context;

  String get _getStringHeder {
    return widget.logIn ? 'Please log in' : 'Please register';
  }

  String get _getStringTextButtonAccount {
    return widget.logIn ? 'I don’t have an account' : 'I’ve got the account';
  }


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
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            // color: Colors.red,
            child: Padding(
              padding: EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 0),
              child: Container (
                child: Column(children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(_getStringHeder,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Const.darkGray,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(height: 8),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text('You’ll get more content',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Const.lightGray,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      )),
                  SizedBox(height: 40),
                  _getTextField(true),
                  SizedBox(height: 12),
                  _getTextField(false),
                  _errorContainer,
                  _button,
                  SizedBox(height: 20),
                  _buttonReloadMetod,
                  Spacer(),
                  _textLink,
                  SizedBox(height: 34), 
                ]),
              ),
            ),
          ),
          onTap: () {
            _hideKey();
          },
        ));
  }

  _hideKey(){
      FocusScopeNode currentFocus = FocusScope.of(_context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
  }

  Container get _button {

    return Container(
      width: double.infinity,
      height: 48,
      child: RaisedButton(
        color: _isEnableGooButton ? Const.blue : Const.lightGray,
        child: Text('Continue',
            style: TextStyle(
                color: _isEnableGooButton ? Colors.white : 'F4F3F0'.getColor(),
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        onPressed: _isEnableGooButton
            ? () {
                _incrementCounter();
              }
            : null,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(8.0))),
    );

  }

  bool get _isEnableGooButton {

    if (_login.length > 3) {
      if (_password.length > 3) {
        return true;
      }
    }

    return false;
  }

  Container get _buttonReloadMetod{
    return Container(
      height: 62,
      width: double.infinity,
      child: Center(
        child: GestureDetector(
          onTap: (){
            widget.logIn = !widget.logIn;
            setState(() {});
          },
          child: Text(_getStringTextButtonAccount,
            style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.w400)),
        ),
      ),
    );

  }

  BoxDecoration get _decoration {

    return BoxDecoration(
      color: 'F2F4F6'.getColor(),
    border: Border.all(
      color: _error == null ? Colors.transparent : 'FF5A5F'.getColor(),
      width: 1.0
    ),
    borderRadius: BorderRadius.all(
        Radius.circular(8.0) //           
    ),
  );

  }

  Container _getTextField(bool isUpTF) { 

    final textUp = widget.logIn ? "E-mail" : "Name";
    final textDown = widget.logIn ? "Password" : "E-mail";
    


    return Container(
      height: 48,
      width: double.infinity,
      decoration: _decoration,
      child: TextField(
      // focusNode: _focusNode,
      // obscuringCharacter: '• ',
      obscureText: !isUpTF,
      style: TextStyle(fontSize: 16.0, color: Const.darkGray, fontWeight: FontWeight.w400),
      cursorColor: Const.darkGray,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: isUpTF ? textUp : textDown,
        hintStyle: TextStyle(
            fontSize: 16.0,
            color: Const.midleGray,
            fontWeight: FontWeight.w400),
        contentPadding:
            EdgeInsets.only(left: 16, bottom: 13, top: 13, right: 15),
      ),
      textAlign: TextAlign.left,
      onChanged: (str) {
        if (isUpTF) {
          _login = str;
        } else {
          _password = str;
        }
        _error = null;
        setState(() {});
      },
      onSubmitted: (str) {
        //если пользователь нажал ВВод
        if (isUpTF) {
          FocusScope.of(_context).previousFocus();
        }
      },
    ),
  );


  }

  Widget get _textLink{
    return Container(
      width: double.infinity,
      height: 60,
      child: Text('By continuing, you agree with the QUT\nTerms of Service and confirm that you\nhave read the Privacy Policy',
      textAlign: TextAlign.center,
      style: TextStyle(
        height: 1.3,
                color: Const.midleGray,
                fontSize: 14,
                fontWeight: FontWeight.w400))
    );
  }

  Widget get _errorContainer {
    if (_error == null){
      return SizedBox(height: 40);
    }

    final text = _error.errorDescription ?? "Invalid email or password";

    return Container(
      width: double.infinity,
      height: 40,
      child: Padding(
        padding: EdgeInsets.only(top: 4, bottom: 16),
        child: Text(text,
        textAlign: TextAlign.left,
        style: TextStyle(
                color: 'FF5A5F'.getColor(),
                fontSize: 14,
                fontWeight: FontWeight.w400))
        ),
      );

  }


  void _incrementCounter() {
    _hideKey();
    LoadWindows.presentLoad(_context);

    if (widget.logIn){

    GetTokensRequest api = GetTokensRequest(_login, _password);
    api.load();

    api.endRequest = ({QUTError error}) {
      _autorizReq(error);
    };

    } else {

      RegisterUser req = RegisterUser(email: _password, name: _login);
      req.load();

      req.endRequest = ({QUTError error}) {
        _autorizReq(error);
      };
    }
  }

  //запрос на выбранные категории
  //
  //
  _loadFavoritTheme(){
    final themes = TagsCurtainSingelton.shared.getListDictionary;
    if (themes.isNotEmpty){
      final req = ReloadFavoritCategory();

      req.load();
      req.endRequestListJson = ({List<dynamic> objs, QUTError error}){
        _finish();
      };

    } else{
      _finish();
    }

  }

  _autorizReq(QUTError error){
      if (error == null) {
        _loadFavoritTheme();
      } else {
        _error = error;
        setState(() {});
      }
  }

  _finish(){
      widget.goodRequest();
      LoadWindows.dissmisLoad(_context);
      Navigator.of(_context).popUntil((route) => route.isFirst);
      // Navigator.pop(_context);

      // if 
  }




}


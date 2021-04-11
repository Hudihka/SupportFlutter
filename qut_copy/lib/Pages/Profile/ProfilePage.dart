import 'package:flutter/material.dart';
import 'package:qut/Pages/Profile/SettingsPage.dart';
import 'package:qut/Pages/TabBar/WidgetTabBar.dart';
import 'package:qut/Views/BBItem/BBItem.dart';
import 'package:qut/imports.dart';

export 'package:qut/Pages/TabBar/WidgetTabBar.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ProfilePageContent();
  }
}

class ProfilePageContent extends StatelessWidget {

  BuildContext _context;
  ProfileCubit _profileCubit;

  bool _isAutoriz;

  @override
  Widget build(BuildContext context) {
    //говорит о том, что грузим юзеров при запуске
    _context = context;

    _profileCubit = context.read();
    _profileCubit.fetchContent();


    return BlocConsumer<ProfileCubit, ProfileState>(builder: (context, state) {
      if (state is ProfileState) {
        bool loadStatus = state.loadStatus ?? true;
        _isAutoriz = state.isAutoriz ?? false;

        if (loadStatus){
          return _scafoldLoad;
        } else {
          return _scafoldContent;
        }

      }

      return SizedBox();
    }, listener: (context, state) {
      if (state is ProfileState) {
        if (state.error != null) {
          ShowView.showAlertError(state.error, _context);
        }
      }
    });
  }


    Scaffold get _scafoldLoad {

    final body = Center(
          child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Const.darkGray),
                    ),
        );

    return Scaffold(
        backgroundColor: Colors.white,
        body: body,
      );
  }

  Scaffold get _scafoldContent {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        actions: [

          BBItem(
              shadow: false,
              imageName: 'assets/icons/BBItem/BBItemGears.png',
              action: () {
                Navigator.push(
              _context,
              MaterialPageRoute(builder: (context) => SettingsPage()));
              }),

        ],
      ),
      body: _bodyContent,
      backgroundColor: Colors.white,
    );
  }

  Widget get _bodyContent {
     return Column(
       children: [
         Text(_isAutoriz ? 'Babai, we’ve saved' : 'Hey, we’ve saved', 
         style: TextStyle(color: Const.darkGray, fontSize: 24, fontWeight: FontWeight.bold),
         textAlign: TextAlign.center,),
         SizedBox(height: 4),
         Text('100 h 500 m', 
         style: TextStyle(color: Const.blue, fontSize: 32, fontWeight: FontWeight.bold),
         textAlign: TextAlign.center,),
         SizedBox(height: 4),
         Text('of your time 😉', 
         style: TextStyle(color: Const.darkGray, fontSize: 24, fontWeight: FontWeight.bold),
         textAlign: TextAlign.center,),
         SizedBox(height: 24),
         Text(_isAutoriz ? 'You seem to be a QUT lover!\nFind more exciting content' : 'Please register to save more', 
         style: TextStyle(color: Const.lightGray, fontSize: 16, fontWeight: FontWeight.w400),
         textAlign: TextAlign.center,),
         SizedBox(height: 24),
         _button
       ],
     );
  }


  Widget get _button {

      return Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Container(
      width: double.infinity,
      height: 48,
      child: RaisedButton(
        color: Const.blue,
        child: Text(_isAutoriz ? 'Explore' : 'Log in',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        onPressed: () {
                _actionButton();
              },
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(8.0))),
    ),
      );

  }

  void _actionButton(){
    if (_isAutoriz) {
      MiniPlayerSingelton.shared.getCubit.newSelectedIndex(1);
    } else {

    final autoriz = AutorizationPage(logIn: false);

    autoriz.goodRequest = (){
      _profileCubit.fetchContent();
    };

    Navigator.push(
              _context,
              MaterialPageRoute(builder: (context) => autoriz));
  }
    }

  
}

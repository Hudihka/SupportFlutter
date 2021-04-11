

import 'package:flutter/material.dart';

class FullScreenButton extends StatelessWidget {

  bool openFullScreen;
  Function taped;

  FullScreenButton({@required this.openFullScreen});

  @override
  Widget build(BuildContext context) {
    return _fullScreen();
  }


  Widget _fullScreen() {

    final double width = openFullScreen ? 80 : 45;
    final double padding = openFullScreen ? 51 : 16;

    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        width: width,
        height: 45,
        child: Padding(
            padding: EdgeInsets.only(left: padding, top: 0, right: 0, bottom: 20),
            child: GestureDetector(
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/icons/VideoPlayer/Fullscreen.png"), 
                    fit: BoxFit.cover),
                  )
                  
                ),
                onTap: () {
                  taped();
                })),
      ),
    );
  }
}


class TimerWidget extends StatelessWidget {

  bool openFullScreen;
  String text;

  TimerWidget({@required this.openFullScreen, @required this.text});

  @override
  Widget build(BuildContext context) {
    return _widget();
  }


  Widget _widget() {

    final double width = openFullScreen ? 70 : 50;
    final double padding = openFullScreen ? 41 : 16;

    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        width: width,
        height: 34,
        child: Padding(
            padding: EdgeInsets.only(left: 0, top: 0, right: padding, bottom: 20),
            child: Text(text,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600),
            )),
      ),
    );
  }
}


class CloseWidget extends StatelessWidget {

  Function taped;


  @override
  Widget build(BuildContext context) {
    return _closeButton();
  }


  Widget _closeButton() {

    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 60,
        height: 60,
        child: Padding(
            padding: EdgeInsets.only(left: 0, top: 30, right: 30, bottom: 0),
            child: GestureDetector(
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/icons/audioPlayer/close.png"), 
                    fit: BoxFit.cover),
                  )
                  
                ),
                onTap: () {
                  taped();
                })),
      ),
    );
  }
}



// 'assets/icons/audioPlayer/close.png'

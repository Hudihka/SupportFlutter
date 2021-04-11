import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:qut/Cubits/TabBarCubit.dart';
import 'package:qut/Models/Content.dart';
import 'package:qut/Support/LogOuth/Const.dart';
import 'package:qut/Support/DowloadImage.dart';
import 'package:qut/Support/MediaContent/BacgroundAudioContent.dart';
import 'package:qut/Support/MediaContent/MediaButtons.dart';
import 'package:qut/Views/MiniPlayerWidget.dart';
import 'package:video_player/video_player.dart';

import 'package:qut/Extension/Int.dart';
import 'package:qut/Extension/Duration.dart';
import 'package:qut/Support/DisposableWidget.dart';
import 'package:rxdart/rxdart.dart';

import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:qut/Models/Content.dart';
import 'package:qut/Support/DisposableWidget.dart';
import 'package:qut/Views/MiniPlayerWidget.dart';
import 'package:rxdart/rxdart.dart';

class PlayerWidget extends StatefulWidget {
  Content content;
  GlobalKey key;


  PlayerWidget({@required this.content,
                @required this.key});

  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> with DisposableWidget {
  VideoPlayerController _controller;

  final mediaSingl = MiniPlayerSingelton.shared;

  bool _isInitalisPlayer = false; // когда занрузилось видео он становится тру
  bool _showButtons = false; //показаны кнопки или нет
  Timer _timerClearButton;

  bool _isAudioPlayning = false;
  int _leftTime;

  //методы для плеера
  // AsyncSnapshot<dynamic> _snapshot;
  MediaState _mediaState; 


  TabBarCubit get _tabBarCubit {
    return mediaSingl.getCubit;
  }


  bool get _openFullScreen {
    return _tabBarCubit.contentState.enumType ==
        EnumTabBar.horizontalScreen;
  }

  bool get _openMiniScreen {
    return _tabBarCubit.contentState.enumType ==
        EnumTabBar.miniMedia;
  }

  bool get _isVideoContent {
    return widget.content.type == EnumContentTupeCell.video;
  }


  // ВОСПРОИЗВЕДЕНИЕ КОНТЕНТА
  
  @override
  void initState() {
    if (_isVideoContent) {
      _openVideo();
    } else {
      _playAudio();
    }

    super.initState();
  }

  _openVideo() {
    _controller = VideoPlayerController.network(widget.content.content_link)
      ..initialize().then((error) {
        _isInitalisPlayer = true;
        mediaSingl.savePlayStatus(true);
        setState(() {});

        _controller.addListener(() {
          setState(() {});
        });
        _actionPlayPause();
      });
  }

  //воспроизведение аудио
  ///////////////////////
 
  _playAudio(){

    AudioService.runningStream.listen((event) {

      print('------------------------1');

        final running = event ?? false;

            if (!running){
              _start();
            }

    }).canceledBy(this);

    AudioService.playbackStateStream
                        .map((state) => state.playing)
                        .distinct().listen((event) {


          print('------------------------2');

                        mediaSingl.savePlayStatus(event);
                        _isAudioPlayning = event;

                        }).canceledBy(this);


    _mediaStateStream.listen((event) {
                              _mediaState = event;

          print('------------------------3');

                              final processingState = event.position.inSeconds;
      

                              if (_position != null){
                                _leftTime =  _position;

                                if (_isInitalisPlayer == false){
                                  mediaSingl.savePlayStatus(true);
                                  _isInitalisPlayer = true;
                                }

                                setState(() {});
                              }
    }).canceledBy(this);


  }

    int get _duration {
    return _mediaState?.mediaItem?.duration?.inSeconds ?? 0;
  }

  int get _position {
    final position = _mediaState?.position?.inSeconds;

    if (position == null){
      return null;
    }

    if (_duration == null){
      return null;
    }

    final left = _duration - position;

    return left;
  }


      _start(){
                AudioService.start(
            backgroundTaskEntrypoint: audioPlayerTaskEntrypoint,
            androidNotificationChannelName: 'Audio Service Demo',
            androidNotificationColor: 0xFF2196f3,
            androidNotificationIcon: 'mipmap/ic_launcher',
            androidEnableQueue: true,
            params: MiniPlayerSingelton.shared.getCubit.contentState.contentSelected.toJson()
          );
    }

    Stream<MediaState> get _mediaStateStream =>
      Rx.combineLatest2<MediaItem, Duration, MediaState>(
          AudioService.currentMediaItemStream,
          AudioService.positionStream,
          (mediaItem, position) => MediaState(mediaItem, position));

///////////////////////

  @override
  Widget build(BuildContext context) {
    return Stack(children: _allWidgetList);
  }

  @override
  void dispose() {
    super.dispose();
    mediaSingl.savePlayStatus(false);
    if (_isVideoContent) {
      _controller.dispose();
    } else {
      cancelSubscriptions();
    }
  }

  //ВЕРСТКА


  List<Widget> get _allWidgetList {
    if (_openMiniScreen) {
      return [_widgetMiniScreen];
    }

    List<Widget> listButtons = [
      Center(
          child: _gestureDetector(60, 60, _imageNamePlay, () {
        _actionPlayPause();
      })),
    ];

    final timer = [
      TimerWidget(openFullScreen: _openFullScreen, text: _textTimer)
    ];

    final fullScreen = FullScreenButton(
      openFullScreen: _openFullScreen,
    );

    fullScreen.taped = () {
      _openFullScreen ? 
      _tabBarCubit.dismisHorizontalWindows() 
      : _tabBarCubit.openHorizontalWindows();
    };

    //это только для видео

    List<Widget> fullWindows = _isVideoContent ? [fullScreen] : [];

    if (_openFullScreen) {
      final closeButton = CloseWidget();
      closeButton.taped = () {
        _tabBarCubit.dismisHorizontalWindows();
      };
      fullWindows.add(closeButton);
    }

    return [_baseWidgetList] +
        listButtons +
        _gestureAnimateWidget +
        fullWindows +
        timer;
  }

  Widget get _widgetMiniScreen {
    return Row(
      children: [
        Container(
          height: 44,
          width: 80,
          child: _baseWidgetList,
        ),
        SizedBox(
          width: 12,
        ),
        Container(
          height: 44,
          width: Const.wDevice - 208,
          alignment: Alignment.centerLeft,
          child: Text(
            widget.content.name,
            maxLines: 2,
            style: TextStyle(
                color: Const.darkGray,
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Container(
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
                      onPressed: () {
                        _actionPlayPause();
                      },
                      child: Image.asset(_imageNamePlay)),
                )),
          ),
        )
      ],
    );
  }

  //это базовые виджеты, что будут всегда

  Widget get _baseWidgetList {
    double height = Const.heightVideo;

    if (_openFullScreen) {
      height = Const.wDevice;
    } else if (_openMiniScreen) {
      height = 44;
    }

    //это самый нижний виджет, либо плейсхолдер, либо видео вью

    if (_isVideoContent) {
      return _isInitalisPlayer
          ? Center(
              child: _controller.value.isInitialized
                  ? VideoPlayer(_controller)
                  : Container(
                      color: Colors.black,
                    ))
          : DowloadImage(widget.content.content_preview, height, 0);
    } else {
      final double radius = _openMiniScreen ? 4 : 0;
      return DowloadImage(widget.content.content_preview, height, radius);
    }
  }

  //это виджет что задает анимацию показа кнопок

  List<Widget> get _gestureAnimateWidget {
    if (_isInitalisPlayer == false) {
      return [];
    }

    return [
      GestureDetector(
        onTap: () {
          _showButtons = !_showButtons;
          _actionTimer();
          _actionPlayPause();
          setState(() {});
        },
      )
    ];
  }

  bool get itsPlayContent {
    if (_isVideoContent) {
      return _controller.value.isPlaying;
    } else {
      return _isAudioPlayning;
    }
  }

  //ОСТАВШЕЕСЯ ВРЕМЯ

  String get _textTimer {


    if (_isVideoContent) {
      return _isInitalisPlayer
          ? _restOfTime.durationContent
          : widget.content.content_qut_duration.durationContent;
    } else {
      return _restOfTime.durationContent;
    }
  }

  int get duration {
    return widget.content.content_qut_duration;
  }

  int get _restOfTime {
    if (_isVideoContent) {
      final position = _controller.value.position.countSeconds;
      final full = _controller.value.duration.countSeconds;

      return full - position;
    } else {
      return _leftTime ?? widget.content.content_qut_duration;
    }
  }


  //Кнопка плей/пауза

  String get _imageNamePlay {
    final pause = _openMiniScreen
        ? 'assets/icons/audioPlayer/pause.png'
        : "assets/icons/VideoPlayer/Pause_video_Circle.png";
    final play = _openMiniScreen
        ? 'assets/icons/audioPlayer/play.png'
        : "assets/icons/VideoPlayer/Play_video_Circle.png";

    if (_isInitalisPlayer == false) {
      return null;
    }

    if (_restOfTime == 0) {
      return play;
    }

    return itsPlayContent ? pause : play;
  }

  //ЭКШЕН ПЛЕЙ ПАУЗА

  void _actionPlayPause() {
    if (_isVideoContent) {
      _actionPlayPauseVideo();
    } else {
      mediaSingl.savePlayStatus(!itsPlayContent);
      itsPlayContent ? AudioService.pause() : AudioService.play();
      // _player.actionPlayPause();
    }

    
    setState(() {});
  }

  

  void _actionPlayPauseVideo() {
    if (_restOfTime == 0) {
      //воспроизвести повторно
      _controller.initialize();
      _controller.play();
      setState(() {});
      return;
    }
    mediaSingl.savePlayStatus(!itsPlayContent);

    itsPlayContent ? _controller.pause() : _controller.play();
  }

  AnimatedOpacity _gestureDetector(
      double width, double height, String nameImage, Function tapGestures) {
    final boxDecoration = _isInitalisPlayer ? _decorationFrom(nameImage) : null;

    Function gester = null;

    if (_showButtons) {
      if (_isInitalisPlayer) {
        gester = tapGestures;
      }
    }

    final widgetGesture = GestureDetector(
        child: Container(
          width: width,
          height: height,
          decoration: boxDecoration,
        ),
        onTap: () {
          if (gester != null) {
            gester();
          }

          _actionTimer();
        });

    final animateWidget = AnimatedOpacity(
      child: widgetGesture,
      duration: Duration(milliseconds: 250),
      opacity: _showButtons ? 1 : 0,
    );

    return animateWidget;
  }

  BoxDecoration _decorationFrom(String nameImage) {
    return BoxDecoration(
      image: DecorationImage(image: AssetImage(nameImage), fit: BoxFit.cover),
    );
  }

  //ТАЙМЕР

  _actionTimer() {
    if (_timerClearButton != null) {
      _timerClearButton.cancel();
    }

    if (_isInitalisPlayer) {
      //если видео загружено
      if (_showButtons) {
        //и если кнопки в данный момет показаны

        _timerClearButton = Timer(Duration(seconds: 3), () {
          if (_showButtons) {
            //кнопки до сих пор видно
            _showButtons = false;
            setState(() {});
          }
        });
      }
    }
  }

}



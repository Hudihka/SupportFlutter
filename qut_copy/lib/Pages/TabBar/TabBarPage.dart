import 'package:audio_service/audio_service.dart';
import 'package:qut/Pages/Profile/ProfilePage.dart';
import 'package:qut/Pages/TabBar/WidgetTabBar.dart';
import 'package:qut/imports.dart';

export 'package:qut/Pages/TabBar/WidgetTabBar.dart';

class TabBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Const.setSize(context);
    LastContext.addContext(context);

    return TabBarContent();
  }
}

class TabBarContent extends StatelessWidget {
  int _currentIndex = 0;
  final mediaSinglton = MiniPlayerSingelton.shared;

  BuildContext _context;
  // TabBarCubit _contentCubit;
  PlayerWidget _widgetMedia;

  Content _selectedContent;
  EnumTabBar _enumTabBar;

  @override
  Widget build(BuildContext context) {
    //говорит о том, что грузим юзеров при запуске
    _context = context;

    // _contentCubit = context.read();
    // _contentCubit.fetchContent(null);

    // mediaSinglton.saveCubit(_contentCubit);

    return BlocConsumer<TabBarCubit, TabBarState>(builder: (context, state) {
      if (state is TabBarState) {
        _currentIndex = state.selectedIntdex ?? 0;
        _selectedContent = state.contentSelected;
        _enumTabBar = state.enumType ?? EnumTabBar.emptyContent;

        _createWidgetMedia(state.key);

        return _scaffoldContent;
      }

      return SizedBox();
    }, listener: (context, state) {
      if (state is TabBarState) {
        if (state.error != null) {
          ShowView.showAlertError(state.error, _context);
        }
      }
    });
  }

  //ЧТО СОБСТВЕННО ПОКАЗЫВАЕМ В ТАБ БАРЕ

  Widget get _scaffoldContent {

    Color color = Colors.transparent;

    final type = MiniPlayerSingelton.shared?.getCubit?.state?.enumType ?? EnumTabBar.emptyContent;

    if (type == EnumTabBar.fullScreen){
      color = Colors.white;
    } else if (type == EnumTabBar.horizontalScreen){
      color = Colors.black;
    }

    return Stack(
      children: [

        Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: getScaffoldForIndex,
        bottomNavigationBar: SizedBox(height: _enumTabBar.heightTabBar, child: _content())),

        Container(
          height: Const.statusBarHeight,
          width: double.infinity,
          color: color
        ),

      ]
    );

    // return Scaffold(
    //     extendBodyBehindAppBar: true,
    //     extendBody: true,
    //     body: getScaffoldForIndex,
    //     bottomNavigationBar: SizedBox(height: _enumTabBar.heightTabBar, child: _content()));
  }

  Widget _content() {
    switch (_enumTabBar) {
      case EnumTabBar.fullScreen:
        return _contentFullScreen();
      case EnumTabBar.horizontalScreen:
        return _contententHorizontalFullScreen();
      default:
        return _contentNoFullScreen();
    }
  }

  Widget _contentFullScreen() {
// [AudioServiceWidget(child: _player)

if (_selectedContent.type == EnumContentTupeCell.text){
  return DetailInfoPageText();
}

if (_selectedContent.type == EnumContentTupeCell.audio){
  return AudioServiceWidget(child: DetailInfoPageMedia(widgetMedia: _widgetMedia));
}

    return DetailInfoPageMedia(widgetMedia: _widgetMedia);
}

  Widget _contententHorizontalFullScreen() {
    final fullScreen = FullScreenWindows(
      widgetMedia: _widgetMedia,
    );

    return fullScreen;
  }

//
  Widget _contentNoFullScreen() {
    final offset = (Const.wDevice - 248) / 2;
    final empty = _enumTabBar == EnumTabBar.emptyContent;

    final widgetButtons = Container(
        color: empty ? Colors.transparent : Colors.white,
        width: double.infinity,
        height: 75,
        child: Padding(
          padding: EdgeInsets.only(bottom: 23, left: offset, right: offset, top: 2),
          child: WidgetTabBar(),
        ));

    if (empty == false) {
      //показываем мини виджет
      return Column(
        children: [MiniPlayerWidget(widgetContent: _widgetMedia), widgetButtons],
      );
    }

    return widgetButtons;
  }

  _createWidgetMedia(GlobalKey key) {
    if (_enumTabBar == EnumTabBar.emptyContent) {
      _widgetMedia = null;
    } else {
      _widgetMedia = PlayerWidget(content: _selectedContent, key: key);
    }
  }

//СДЕЛАНО ТАК СПЕЦИАЛЬНО
//СМОТРИ Lenta() там рассписано почему такой костыль

  final List<Widget> _children = [
    LentaPage(),
    ExplorePage(),
    FeaturePage(),
    ProfilePage()
  ];

  Widget get getScaffoldForIndex {
    return _children[_currentIndex];
  }
}

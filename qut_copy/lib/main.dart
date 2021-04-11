import 'package:app_logger/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qut/Cubits/ContentCubit.dart';
import 'package:qut/Cubits/ExploreCubit/ExploreCubit.dart';
import 'package:qut/Cubits/FeatureCubit/FeatureCubit.dart';
import 'package:qut/Cubits/TabBarCubit.dart';
import 'package:qut/Views/MiniPlayerWidget.dart';
import 'package:qut/imports.dart';

import 'Pages/TabBar/TabBarPage.dart';
import 'AppEnv.dart';

void main() {
  runApp(MyApp(true));
}

class MyApp extends StatefulWidget {

  bool _started = true;

  MyApp(this._started);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TabBarCubit tabBarCubit = TabBarCubit(TabBarState())..fetchContent(null);
  ExploreCubit exploreCubit = ExploreCubit();
  FeatureCubit featureCubit = FeatureCubit();
  ProfileCubit profileCubit = ProfileCubit(ProfileState());

  @override
  void initState() {
    AppLogger()
        .init(AppEnv.loggerUrl, AppEnv.loggerProject,
        hasConnect: AppEnv.hasConnectLoggerRemote)
        .then((r) => AppLogger().log('init app'));

    BaseRequest.init();

    MiniPlayerSingelton.shared.saveCubit(tabBarCubit);

    exploreCubit.load();
    featureCubit.load();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<TabBarCubit>(
          create: (context) => tabBarCubit,
        ),
        BlocProvider<ContentCubit>(
          create: (context) => ContentCubit(ContentState())..fetchContent(),
        ),
        BlocProvider<ExploreCubit>(create: (context) => exploreCubit),
        BlocProvider<FeatureCubit>(create: (context) => featureCubit),
        BlocProvider<ProfileCubit>(create: (context) => profileCubit),
      ],
      child:  MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TabBarPage(), //_started ? AutorizationPage() : TwoVC(),
        routes: {
          FeatureCategoryPage.route: (ctx) => FeatureCategoryPage(),
        },
      ),
    );
  }
}

/*

https://github.com/kokohuang/flutter_easyloading

добавь в проект для ios
<key>io.flutter.embedded_views_preview</key><string>yes</string>
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
    <key>NSAllowsArbitraryLoadsInWebContent</key>
    <true/>
</dict>




*/

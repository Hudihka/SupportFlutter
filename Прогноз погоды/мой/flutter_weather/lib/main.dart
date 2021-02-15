import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/blocs/simple_bloc_observer.dart';
import 'package:flutter_weather/repositories/weather_api_client.dart';
import 'package:flutter_weather/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'blocs/weather_bloc.dart';
import 'package:flutter_weather/widgets/weather.dart';

void main() {
  //пример взят отсюда https://bloclibrary.dev/#/flutterweathertutorial
  Bloc.observer = SimpleBlocObserver();

    final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(App(weatherRepository: weatherRepository));
}


class App extends StatelessWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather',
      home: BlocProvider(
        create: (context) => WeatherBloc(weatherRepository: weatherRepository),
        child: Weather(),
      ),
    );
  }
}
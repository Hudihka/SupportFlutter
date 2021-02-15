import 'package:flutter_weather/modeles/weather.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_weather/models/models.dart';

/*

WeatherInitial - наше начальное состояние, в котором не 
будет данных о погоде, потому что пользователь еще не выбрал город

WeatherLoadInProgress - состояние, которое будет происходить, 
пока мы получаем погоду для данного города

WeatherLoadSuccess - состояние, которое произойдет, 
если мы сможем получить погоду для данного города.

WeatherLoadFailure - состояние, которое произойдет, 
если мы не сможем получить погоду для данного города.

*/

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoadInProgress extends WeatherState {}

class WeatherLoadSuccess extends WeatherState {
  final Weather weather;

  const WeatherLoadSuccess({@required this.weather}) : assert(weather != null);

  @override
  List<Object> get props => [weather];
}

class WeatherLoadFailure extends WeatherState {}
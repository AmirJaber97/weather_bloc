import 'dart:async';

import 'package:auslogicstest/models/models.dart';
import 'package:auslogicstest/models/weather_by_day_model.dart';
import 'package:auslogicstest/services/weather_api_client.dart';
import 'package:meta/meta.dart';

class WeatherRepo {
  final Api api;

  WeatherRepo({@required this.api}) : assert(api != null);

  Future<WeatherByDayModel> fetchWeatherByDay({bool next, bool previous}) async {
    return await api.fetchWeatherByDay(nextDay: next, previousDay: previous);
  }

  Future<WeatherModel> fetchWeather() async {
    return await api.fetchWeather();
  }
}

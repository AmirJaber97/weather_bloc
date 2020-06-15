import 'dart:convert';

import 'package:auslogicstest/app/logger.dart';
import 'package:auslogicstest/models/models.dart';
import 'package:auslogicstest/models/weather_by_day_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class Api {
  var logger = getLogger("Api");
  final _baseUrl = 'https://www.metaweather.com/api/location/44418';
  final http.Client httpClient;

  Api({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<WeatherByDayModel> fetchWeatherByDay(
      {bool nextDay, bool previousDay}) async {
    DateTime day = DateTime.now();

    List<WeatherByDayModel> weathers = List<WeatherByDayModel>();

    if(nextDay != null) {
      logger.i("Adding to $day");
      day = DateTime(day.year, day.month, day.day + 1);
      logger.i("Added  $day");

    }
    if(previousDay != null) {
      logger.i("Adding to $day");
      day = DateTime(day.year, day.month, day.day + -1);
      logger.i("Added  $day");
    }
    String dateSlug =
        "${day.year.toString()}/${day.month.toString().padLeft(2, '0')}/${day.day.toString().padLeft(2, '0')}";

    var response;
    logger.i("Getting weather data... from $nextDay - $previousDay $_baseUrl/$dateSlug}");

    try {
      response = await httpClient.get("$_baseUrl/$dateSlug");
      jsonDecode(response.body).forEach((w) {
        weathers.add(WeatherByDayModel.fromJson(w));
      });
      return weathers.first;
    } catch (e) {
      logger.e('Error: $e}');
      throw Exception("Error getting weather data");
    }
  }

  Future<WeatherModel> fetchWeather() async {
    var response;
    logger.i("Getting weather data... from $_baseUrl}");

    try {
      response = await httpClient.get("$_baseUrl");
      return WeatherModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      logger.e('Error Weather model: $e');
      throw Exception("Error getting weather data");
    }
  }
}

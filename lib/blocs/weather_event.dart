import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {
final bool next;
final bool previous;

  const FetchWeather({this.next, this.previous});

  @override
  List<Object> get props => [];
}

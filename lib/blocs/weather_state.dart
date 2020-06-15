import 'package:auslogicstest/models/models.dart';
import 'package:auslogicstest/models/weather_by_day_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherNull extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherByDayModel weatherByDay;
  final WeatherModel weather;

  const WeatherLoaded({@required this.weather, @required this.weatherByDay})
      : assert(weather != null, weatherByDay != null);

  @override
  List<Object> get props => [weatherByDay, weather];
}

class WeatherError extends WeatherState {}

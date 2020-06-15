import 'package:auslogicstest/blocs/weather_event.dart';
import 'package:auslogicstest/blocs/weather_repo.dart';
import 'package:auslogicstest/blocs/weather_state.dart';
import 'package:auslogicstest/main.dart';
import 'package:auslogicstest/models/models.dart';
import 'package:auslogicstest/models/weather_by_day_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepo repository;

  WeatherBloc({@required this.repository}) : assert(repository != null);

  @override
  WeatherState get initialState => WeatherNull();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final WeatherModel weather = await repository.fetchWeather();
        final WeatherByDayModel weatherByDay =
            await repository.fetchWeatherByDay(next: event.next, previous: event.previous);
        yield WeatherLoaded(weather: weather, weatherByDay: weatherByDay);
      } catch (_) {
        yield WeatherError();
      }
    }
  }
}

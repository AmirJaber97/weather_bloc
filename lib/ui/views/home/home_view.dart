import 'package:auslogicstest/blocs/bloc.dart';
import 'package:auslogicstest/ui/views/components/weather_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  bool notToday = false;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherNull) {
          BlocProvider.of<WeatherBloc>(context).add(FetchWeather());
        }
        if (state is WeatherError) {
          return Center(
            child: Text('failed to fetch weather data'),
          );
        }
        if (state is WeatherLoaded) {
          return SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Center(
                  child: Text(
                    state.weather.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: WeatherCard(
                      weatherByDayModel: state.weatherByDay,
                      weatherModel: state.weather,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      !notToday
                          ? RaisedButton(
                              onPressed: () {
                                BlocProvider.of<WeatherBloc>(context)
                                    .add(FetchWeather(previous: true));
                                setState(() {
                                  notToday ^= true;
                                });
                              },
                              child: Text('Previous Day'),
                            )
                          : Container(),
                      notToday
                          ? RaisedButton(
                              onPressed: () {
                                BlocProvider.of<WeatherBloc>(context)
                                    .add(FetchWeather());
                                setState(() {
                                  notToday ^= true;
                                });
                              },
                              child: Text('Today'),
                            )
                          : Container(),
                      !notToday
                          ? RaisedButton(
                              onPressed: () {
                                BlocProvider.of<WeatherBloc>(context)
                                    .add(FetchWeather(next: true));
                                setState(() {
                                  notToday ^= true;
                                });
                              },
                              child: Text('Next Day'),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

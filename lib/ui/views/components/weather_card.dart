import 'package:auslogicstest/models/models.dart';
import 'package:auslogicstest/models/weather_by_day_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherCard extends StatefulWidget {
  final WeatherModel weatherModel;
  final WeatherByDayModel weatherByDayModel;

  const WeatherCard({
    Key key,
    this.weatherModel,
    this.weatherByDayModel,
  }) : super(key: key);

  @override
  _WeatherCardState createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Get.defaultDialog(
            title: 'Info',
            middleText: 'You opened ID ${widget.weatherModel.title}')
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 165.0,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3.0),
                                      child: Text(
                                        'Woeid: ${widget.weatherModel.woeid}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: false,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Wind speed: ${widget.weatherByDayModel.windSpeed}',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: false,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                        'Air pressure: ${widget.weatherByDayModel.airPressure ?? ''}'),
                                    Text(
                                        'Temperature: ${widget.weatherByDayModel.theTemp ?? ''}'),
                                    Text(
                                        'Min Temp: ${widget.weatherByDayModel.minTemp ?? ''}'),
                                    Text(
                                        'Max Temp: ${widget.weatherByDayModel.minTemp ?? ''}'),
                                    Text(
                                        'Date: ${widget.weatherByDayModel.applicableDate ?? ''}')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                                'Humidity: ${widget.weatherByDayModel.humidity}'),
                          ],
                        )
                      ],
                    ),
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                        'Predictability: ${widget.weatherByDayModel.predictability}'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                        'Wind direction: ${widget.weatherByDayModel.windDirectionCompass}'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

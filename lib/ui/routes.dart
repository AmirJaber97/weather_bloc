import 'package:auslogicstest/app/logger.dart';
import 'package:auslogicstest/constants/app_routes.dart';
import 'package:auslogicstest/ui/views/home/home_view.dart';

import 'package:flutter/material.dart';

var logger = getLogger("Routes");

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    logger.i(
        'generateRoute | name: ${settings.name} arguments: ${settings.arguments}');

    switch (settings.name) {
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => HomeView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

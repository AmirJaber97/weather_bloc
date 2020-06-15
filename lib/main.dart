import 'package:auslogicstest/app/logger.dart';
import 'package:auslogicstest/blocs/bloc.dart';
import 'package:auslogicstest/blocs/weather_repo.dart';
import 'package:auslogicstest/constants/app_strings.dart';
import 'package:auslogicstest/services/weather_api_client.dart';
import 'package:auslogicstest/ui/routes.dart';
import 'package:auslogicstest/ui/views/home/home_view.dart';
import 'package:bloc/bloc.dart' as bloc;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final logger = getLogger('Main');

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, bloc.Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Wait a little to show splash
  Future.delayed(const Duration(seconds: 3), () async {
    // init logger
    Logger.level = Level.info;
    // ensure orientation is portrait
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // init bloc delegate
    BlocSupervisor.delegate = SimpleBlocDelegate();
    // create and inject repo
    final WeatherRepo repository = WeatherRepo(
      api: Api(
        httpClient: http.Client(),
      ),
    );
    // run app
    runApp(MyApp(
      repository: repository,
    ));
  });
}

class MyApp extends StatelessWidget {
  final WeatherRepo repository;

  MyApp({Key key, @required this.repository})
      : assert(repository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      onGenerateRoute: Routes.generateRoute,
      home: Scaffold(
        body: BlocProvider(
            create: (context) => WeatherBloc(repository: repository),
            child: HomeView()),
      ),
    );
  }
}

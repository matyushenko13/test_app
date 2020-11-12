import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_checkbox/bloc/get_estimation/get_estimation_bloc.dart';
import 'package:test_app_checkbox/bloc/history_estimation/history_estimation_bloc.dart';
import 'package:test_app_checkbox/bloc/search_estimation/search_estimation_bloc.dart';
import 'package:test_app_checkbox/components/history_button.dart';
import 'package:test_app_checkbox/screens/get_coordinate_screen.dart';
import 'package:test_app_checkbox/screens/history_screen.dart';
import 'package:test_app_checkbox/screens/main_screen.dart';
import 'package:test_app_checkbox/screens/search_estimation_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HistoryEstimationBloc>(
            create: (BuildContext context) => HistoryEstimationBloc(),
          ),
          BlocProvider<SearchEstimationBloc>(
            create: (BuildContext context) => SearchEstimationBloc(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/',
          // routes: {
          //   '/': (context) => MainScreen(),
          //   '/history': (context) => MainScreen(),
          // },
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(builder: (_) => MainScreen(), settings: settings);
              case '/history':
                return MaterialPageRoute(builder: (_) => HistoryScreen(), settings: settings);
              case '/map':
                return MaterialPageRoute(builder: (_) => GetCoordinateScreen(), settings: settings);
              case '/search':
                return MaterialPageRoute(builder: (_) => SearchEstimationScreen(estimation: settings.arguments,), settings: settings);

              default:
                return MaterialPageRoute(builder: (_) => MainScreen(), settings: settings);
            }
          },
        ),
    );
  }
}

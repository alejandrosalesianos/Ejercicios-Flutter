import 'package:flutter/material.dart';
import 'package:flutter_weather_project/pages/earth_weather.dart';
import 'package:flutter_weather_project/pages/init_page.dart';
import 'package:flutter_weather_project/pages/mapa.dart';
import 'package:flutter_weather_project/pages/menu_weather.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      initialRoute: '/init',
      routes: {
        '/': (context) => const EarthWeatherPage(),
        '/menu': (context) => const MenuNavigator(),
        '/init': (context) => const InitPage(),
      },
    ),
  );
}

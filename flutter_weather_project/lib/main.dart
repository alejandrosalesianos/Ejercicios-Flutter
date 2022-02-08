import 'package:flutter/material.dart';
import 'package:flutter_weather_project/pages/earth_weather.dart';
import 'package:flutter_weather_project/pages/home_page.dart';
import 'package:flutter_weather_project/pages/mapa.dart';
import 'package:flutter_weather_project/pages/menu_weather.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      initialRoute: '/menu',
      routes: {
        '/': (context) => const EarthWeatherPage(),
        '/home': (context) => const HomePage(),
        '/menu': (context) => const Mapa(),
        //'/movie-upcoming-detail': (context) => const MovieUpcomingDetailsPage(),
      },
    ),
  );
}

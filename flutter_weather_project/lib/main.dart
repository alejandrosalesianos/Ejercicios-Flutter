import 'package:flutter/material.dart';
import 'package:flutter_weather_project/pages/earth_weather.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const EarthWeatherPage(),
        //'/menu': (context) => const HomeMenu(),
        //'/movie-popular-detail': (context) => const MoviePopularDetailsPage(),
        //'/movie-upcoming-detail': (context) => const MovieUpcomingDetailsPage(),
      },
    ),
  );
}

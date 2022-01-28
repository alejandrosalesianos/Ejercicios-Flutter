import 'package:flutter/material.dart';
import 'package:flutter_themoviedb/pages/home.dart';
import 'package:flutter_themoviedb/pages/home_menu.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/menu',
      routes: {
        '/': (context) => const HomePage(),
        // When navigating to the "/" route, build the FirstScreen widget.
        '/menu': (context) => const HomeMenu(),
      },
    ),
  );
}

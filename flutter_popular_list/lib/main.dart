import 'package:flutter/material.dart';
import 'package:flutter_popular_list/home_page.dart';
import 'package:flutter_popular_list/people_details.dart';

void main() {
  runApp(MaterialApp(
    title: 'Rutas',
    initialRoute: '/',
    routes: {
      '/': (context) => const HomePage(),
      '/detail': (context) => const PeopleDetails()
    },
  ));
}

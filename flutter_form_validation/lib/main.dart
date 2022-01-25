import 'package:flutter/material.dart';
import 'package:flutter_form_validation/login.dart';
import 'package:flutter_form_validation/onboarding.dart';
import 'package:flutter_form_validation/register.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        '/': (context) => const Onboarding(),
        // When navigating to the "/" route, build the FirstScreen widget.
        '/login': (context) => const LoginPage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/register': (context) => const RegisterPage(),
      },
    ),
  );
}

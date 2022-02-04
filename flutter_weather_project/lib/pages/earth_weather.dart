import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_weather_project/models/current_response.dart';
import 'package:flutter_weather_project/models/earth_weekly_response.dart';
import 'package:flutter_weather_project/styles/styles.dart';
import 'package:http/http.dart' as http;

class EarthWeatherPage extends StatefulWidget {
  const EarthWeatherPage({Key? key}) : super(key: key);

  @override
  _EarthWeatherPageState createState() => _EarthWeatherPageState();
}

class _EarthWeatherPageState extends State<EarthWeatherPage> {
  late Future<Current> currentWeather;
  late Future<List<Daily>> dailyWeather;
  late Future<String> currentName;

  @override
  void initState() {
    currentWeather = fetchCurrentWeather();
    dailyWeather = fetchDailyWeather();
    currentName = fetchCurrentWeatherName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: FutureBuilder<String>(
                  future: currentName,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return _currentWeatherName(snapshot.data!);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  }),
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: Text(''),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<Current> fetchCurrentWeather() async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/onecall?lat=37.3900738&lon=-6.0149929&exclude=minutely&appid=0b424a69dd2333b94bafd47a85876ccc&units=metric'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return EarthWeeklyResponse.fromJson(jsonDecode(response.body)).current;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<List<Daily>> fetchDailyWeather() async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/onecall?lat=37.3900738&lon=-6.0149929&exclude=minutely&appid=0b424a69dd2333b94bafd47a85876ccc&units=metric'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return EarthWeeklyResponse.fromJson(jsonDecode(response.body)).daily;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<String> fetchCurrentWeatherName() async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=37.3900738&lon=-6.0149929&appid=0b424a69dd2333b94bafd47a85876ccc'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return CurrentResponse.fromJson(jsonDecode(response.body)).name;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Widget _currentWeather(Current current) {
  return SizedBox(
    width: 200,
    height: 200,
    child: Text('${current.dt}'),
  );
}

Widget _currentWeatherName(String string) {
  return Padding(
    padding: const EdgeInsets.only(top: 40),
    child: Text(
      string,
      style: Styles.textCiudad,
    ),
  );
}

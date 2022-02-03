import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_weather_project/models/earth_weekly_response.dart';
import 'package:http/http.dart' as http;

class EarthWeatherPage extends StatefulWidget {
  const EarthWeatherPage({ Key? key }) : super(key: key);

  @override
  _EarthWeatherPageState createState() => _EarthWeatherPageState();
}

class _EarthWeatherPageState extends State<EarthWeatherPage> {
  late Future<Current> currentWeather;
  late Future<List<Daily>> dailyWeather;

  @override
  void initState(){
    currentWeather = fetchCurrentWeather();
    dailyWeather = fetchDailyWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: FutureBuilder<Current>(
          future: currentWeather,
          builder: (context,snapshot){
            if (snapshot.hasData){
              return _currentWeather(snapshot.data!);
            }else if (snapshot.hasError){
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }
          ),
      ),
    );
  }
}
Future<Current> fetchCurrentWeather() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=37.3900738&lon=-6.0149929&exclude=hourly,minutely&appid=0b424a69dd2333b94bafd47a85876ccc&units=metric'));

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
        'https://api.openweathermap.org/data/2.5/onecall?lat=37.3900738&lon=-6.0149929&exclude=hourly,minutely&appid=0b424a69dd2333b94bafd47a85876ccc&units=metric'));

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
  Widget _currentWeather(Current current){
    return SizedBox(
        width: 200,
        height: 200,
        child: Text('${current.windSpeed}'),
    );
  }
  
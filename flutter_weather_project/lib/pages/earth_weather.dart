import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_weather_project/models/current_response.dart';
import 'package:flutter_weather_project/models/earth_weekly_response.dart';
import 'package:flutter_weather_project/styles/styles.dart';
import 'package:date_format/date_format.dart';
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
  late Future<List<Hourly>> dailyHourly;

  @override
  void initState() {
    currentWeather = fetchCurrentWeather();
    dailyWeather = fetchDailyWeather();
    currentName = fetchCurrentWeatherName();
    dailyHourly = fetchCurrentWeatherHourly();
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
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  child: Container(
                    color: Styles.date,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: _currentWeatherTime(),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: FutureBuilder<Current>(
                  future: currentWeather,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return _currentWeather(snapshot.data!);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  }),
            ),
            FutureBuilder<List<Hourly>>(
                future: dailyHourly,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _currentWeatherHourlyList(snapshot.data!);
                  } else if (snapshot.hasData) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                }),
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

Future<List<Hourly>> fetchCurrentWeatherHourly() async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/onecall?lat=37.3900738&lon=-6.0149929&exclude=minutely&appid=0b424a69dd2333b94bafd47a85876ccc&units=metric'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return EarthWeeklyResponse.fromJson(jsonDecode(response.body)).hourly;
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
  return Column(
    children: [
      Row(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 20),
                child: Image.network(
                    'http://openweathermap.org/img/wn/${current.weather[0].icon}.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  '${current.temp}º | Feels like ${current.feelsLike}',
                  style: TextStyle(color: Styles.textoFecha),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 50),
            child: Column(
              children: [
                Text(
                  '${current.temp}º',
                  style: Styles.temp,
                ),
                Text(
                  '${current.weather[0].description}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Wind ${current.windSpeed} KM/H',
                  style: TextStyle(color: Styles.textoFecha),
                )
              ],
            ),
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    children: [
                      Image.network(
                          'http://openweathermap.org/img/wn/${current.weather[0].icon}.png'),
                      Text(
                        'Precipitaciones: ${current.clouds}%',
                        style: TextStyle(color: Styles.textoFecha),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      children: [
                        _currentWeatherIcon(current),
                        Text(
                          'Humedad: ${current.humidity}%',
                          style: TextStyle(color: Styles.textoFecha),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    children: [
                      Image.network(
                          'http://openweathermap.org/img/wn/${current.weather[0].icon}.png'),
                      Text(
                        'Viento: ${current.windSpeed}km/h',
                        style: TextStyle(color: Styles.textoFecha),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      children: [
                        _currentWeatherIcon(current),
                        Text(
                          'Presion: ${current.pressure}',
                          style: TextStyle(color: Styles.textoFecha),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      )
    ],
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

Widget _currentWeatherTime() {
  String _selectedDateTime = formatDate(
      DateTime.now(), [DD, ", ", dd, " ", MM, " ", yyyy],
      locale: const SpanishDateLocale());
  return Text(_selectedDateTime, style: TextStyle(color: Styles.textoFecha));
}

Widget _currentWeatherIcon(Current current) {
  if (current.humidity >= 50) {
    return Image.network('http://openweathermap.org/img/wn/09d.png');
  } else {
    return Image.network('http://openweathermap.org/img/wn/01d.png');
  }
}

Widget _currentWeatherHourlyList(List<Hourly> hourlyList) {
  return SizedBox(
    width: 600,
    height: 120,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hourlyList.length,
        itemBuilder: (context, index) {
          return _currentWeatherHourly(hourlyList.elementAt(index));
        }),
  );
}

Widget _currentWeatherHourly(Hourly hourly) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ClipRRect(
      borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20), top: Radius.circular(20)),
      child: Container(
        width: 47,
        color: Styles.container,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _getHour(hourly.dt, true),
                style: TextStyle(color: Styles.textoFecha),
              ),
            ),
            Image.network(
                'http://openweathermap.org/img/wn/${hourly.weather[0].icon}.png'),
            Text(
              '${hourly.temp.toStringAsFixed(0)}º',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )
          ],
        ),
      ),
    ),
  );
}

DateTime _UnixToUtcConverter(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
}

_getHour(int timestamp, bool op) {
  var result = _UnixToUtcConverter(timestamp).toString().split(' ');
  if (op) {
    return result[1].replaceRange(4, 11, '');
  } else {
    return result[0];
  }
}

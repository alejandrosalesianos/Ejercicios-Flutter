import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_popular_list/const.dart';
import 'package:flutter_popular_list/model/popular_response.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Actores famosos',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class PeoplePage extends StatefulWidget {
  const PeoplePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  late Future<List<Results>?> futureResults;

  @override
  void initState() {
    super.initState();
    futureResults = fetchPopularPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60, left: 50, right: 50),
                child: Text(
                  'Los actores y actrices mas populares',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      fontFamily: 'Poppins'),
                ),
              ),
              Text(
                'Febrero de 2022',
                style: TextStyle(color: Colors.white70, fontSize: 10),
              ),
              FutureBuilder<List<Results>?>(
                  future: futureResults,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return PopularPeopleList(snapshot.data!);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Results>?> fetchPopularPeople() async {
    final response = await http
        .get(Uri.parse('${Const.movieDB}?${Const.apiKey}&${Const.language}'));
    if (response.statusCode == 200) {
      return PopularPeopleResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw Exception('Failed to load Album');
    }
  }

  Widget popularPeopleItem(Results people) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: 300,
        height: 100,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(120),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/detail', arguments: people);
                },
                child: Image.network(
                    'https://image.tmdb.org/t/p/w500${people.profilePath}'),
              ),
            ),
            Text(
              '${people.name}',
              style: TextStyle(fontSize: 22, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  Widget PopularPeopleList(List<Results> peopleList) {
    return SizedBox(
      width: 500,
      height: 500,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: peopleList.length,
          itemBuilder: (context, index) {
            return popularPeopleItem(peopleList.elementAt(index));
          }),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_starwars/models/people.dart';
import 'package:flutter_starwars/models/planet.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<People>> personas;
  late Future<List<Planet>> planetas;

  @override
  void initState() {
    personas = fetchPersonas();
    planetas = fetchPlanetas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.person)),
                Tab(icon: Icon(Icons.public_outlined)),
              ],
            ),
            title: const Text('Star Wars'),
          ),
          body: TabBarView(
            children: [
              SizedBox(
                height: 275,
                child: Center(
                    child: FutureBuilder<List<People>>(
                  future: personas,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return _peopleList(snapshot.data!);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                )),
              ),
              SizedBox(
                height: 100,
                child: Center(
                    child: FutureBuilder<List<Planet>>(
                  future: planetas,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return _planetList(snapshot.data!);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
  /*return Scaffold(
      body: Column(
        children: [
          Container(
            height: 275,
            child: Center(
                child: FutureBuilder<List<People>>(
              future: personas,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _peopleList(snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            )),
          ),
          Container(
            height: 220,
            child: Center(
                child: FutureBuilder<List<Planet>>(
              future: planetas,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _planetList(snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            )),
          ),
        ],
      ),
    );
  }*/

  Future<List<People>> fetchPersonas() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/people'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return PeopleResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<Planet>> fetchPlanetas() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/planets'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return PlanetResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Widget _planetItem(Planet planet) {
    List<String> planetas = planet.url.split('/');
    String idPlaneta = planetas[5];
    return SizedBox(
      width: 300,
      child: Card(
        child: InkWell(
            onTap: () {
              debugPrint('Card tapped.');
            },
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                margin: EdgeInsets.all(15),
                elevation: 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Column(
                    children: <Widget>[
                      Image(
                        image: NetworkImage(
                            'https://starwars-visualguide.com/assets/img/planets/${idPlaneta}.jpg'),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(planet.name),
                      ),
                    ],
                  ),
                ))),
      ),
    );
  }

  Widget _peopleItem(People people) {
    List<String> persona = people.url.split('/');
    String idFoto = persona[5];
    return Container(
      width: 300,
      child: Card(
        child: InkWell(
            onTap: () {
              debugPrint('Card tapped.');
            },
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                margin: EdgeInsets.all(15),
                elevation: 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Column(
                    children: <Widget>[
                      Image(
                        image: NetworkImage(
                            'https://starwars-visualguide.com/assets/img/characters/${idFoto}.jpg'),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(people.name),
                      ),
                    ],
                  ),
                ))),
      ),
    );
  }

  Widget _peopleList(List<People> peopleList) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: peopleList.length,
      itemBuilder: (context, index) {
        return _peopleItem(peopleList.elementAt(index));
      },
    );
  }

  Widget _planetList(List<Planet> planetList) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: planetList.length,
      itemBuilder: (context, index) {
        return _planetItem(planetList.elementAt(index));
      },
    );
  }
}

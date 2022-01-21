import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_starwars/models/planet.dart';
import 'package:http/http.dart' as http;
import 'models/people.dart';

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
      home: const MyHomePage(title: 'Personajes'),
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

  @override
  void initState() {
    personas = fetchPeople();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Personajes'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Planetas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomePage2(
                            title: "Planetas",
                          )),
                );
              },
            ),
          ],
        ),
      ),
      body: SizedBox(
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
    );
  }

  Future<List<People>> fetchPeople() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/people'));
    if (response.statusCode == 200) {
      return PeopleResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw Exception('Failed to load people');
    }
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

  Widget _peopleItem(People people) {
    List<String> persona = people.url.split('/');
    String idFoto = persona[5];
    return Container(
      width: 150,
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
}

@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const MyHomePage2(title: 'Flutter Demo Home Page'),
  );
}

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage2> createState() => _MyHomePageState2();
}

class _MyHomePageState2 extends State<MyHomePage2> {
  late Future<List<Planet>> planetas;

  @override
  void initState() {
    planetas = fetchPlanets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Personajes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomePage(
                            title: "Personajes",
                          )),
                );
              },
            ),
            ListTile(
              title: const Text('Planetas'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: 250,
        child: Center(
            child: FutureBuilder<List<Planet>>(
          future: planetas,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _planetsList(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        )),
      ),
    );
  }

  Future<List<Planet>> fetchPlanets() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/planets'));
    if (response.statusCode == 200) {
      return PlanetResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw Exception('Failed to load planets');
    }
  }

  Widget _planetsList(List<Planet> planetsList) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: planetsList.length,
      itemBuilder: (context, index) {
        return _planetItem(planetsList.elementAt(index));
      },
    );
  }

  Widget _planetItem(Planet planet) {
    List<String> planetas = planet.url.split('/');
    String idPlaneta = planetas[5];
    return Container(
      width: 200,
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

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

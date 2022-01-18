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
    return Scaffold(
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
  }

  /*List<People> personas = PeopleResponse.fromJson(jsonDecode(
          '{"count":82,"next":"https://swapi.dev/api/people/?page=2&format=json","previous":null,"results":[{"name":"Luke Skywalker","height":"172","mass":"77","hair_color":"blond","skin_color":"fair","eye_color":"blue","birth_year":"19BBY","gender":"male","homeworld":"https://swapi.dev/api/planets/1/","films":["https://swapi.dev/api/films/1/","https://swapi.dev/api/films/2/","https://swapi.dev/api/films/3/","https://swapi.dev/api/films/6/"],"species":[],"vehicles":["https://swapi.dev/api/vehicles/14/","https://swapi.dev/api/vehicles/30/"],"starships":["https://swapi.dev/api/starships/12/","https://swapi.dev/api/starships/22/"],"created":"2014-12-09T13:50:51.644000Z","edited":"2014-12-20T21:17:56.891000Z","url":"https://swapi.dev/api/people/1/"},{"name":"C-3PO","height":"167","mass":"75","hair_color":"n/a","skin_color":"gold","eye_color":"yellow","birth_year":"112BBY","gender":"n/a","homeworld":"https://swapi.dev/api/planets/1/","films":["https://swapi.dev/api/films/1/","https://swapi.dev/api/films/2/","https://swapi.dev/api/films/3/","https://swapi.dev/api/films/4/","https://swapi.dev/api/films/5/","https://swapi.dev/api/films/6/"],"species":["https://swapi.dev/api/species/2/"],"vehicles":[],"starships":[],"created":"2014-12-10T15:10:51.357000Z","edited":"2014-12-20T21:17:50.309000Z","url":"https://swapi.dev/api/people/2/"},{"name":"R2-D2","height":"96","mass":"32","hair_color":"n/a","skin_color":"white, blue","eye_color":"red","birth_year":"33BBY","gender":"n/a","homeworld":"https://swapi.dev/api/planets/8/","films":["https://swapi.dev/api/films/1/","https://swapi.dev/api/films/2/","https://swapi.dev/api/films/3/","https://swapi.dev/api/films/4/","https://swapi.dev/api/films/5/","https://swapi.dev/api/films/6/"],"species":["https://swapi.dev/api/species/2/"],"vehicles":[],"starships":[],"created":"2014-12-10T15:11:50.376000Z","edited":"2014-12-20T21:17:50.311000Z","url":"https://swapi.dev/api/people/3/"},{"name":"Darth Vader","height":"202","mass":"136","hair_color":"none","skin_color":"white","eye_color":"yellow","birth_year":"41.9BBY","gender":"male","homeworld":"https://swapi.dev/api/planets/1/","films":["https://swapi.dev/api/films/1/","https://swapi.dev/api/films/2/","https://swapi.dev/api/films/3/","https://swapi.dev/api/films/6/"],"species":[],"vehicles":[],"starships":["https://swapi.dev/api/starships/13/"],"created":"2014-12-10T15:18:20.704000Z","edited":"2014-12-20T21:17:50.313000Z","url":"https://swapi.dev/api/people/4/"},{"name":"Leia Organa","height":"150","mass":"49","hair_color":"brown","skin_color":"light","eye_color":"brown","birth_year":"19BBY","gender":"female","homeworld":"https://swapi.dev/api/planets/2/","films":["https://swapi.dev/api/films/1/","https://swapi.dev/api/films/2/","https://swapi.dev/api/films/3/","https://swapi.dev/api/films/6/"],"species":[],"vehicles":["https://swapi.dev/api/vehicles/30/"],"starships":[],"created":"2014-12-10T15:20:09.791000Z","edited":"2014-12-20T21:17:50.315000Z","url":"https://swapi.dev/api/people/5/"},{"name":"Owen Lars","height":"178","mass":"120","hair_color":"brown, grey","skin_color":"light","eye_color":"blue","birth_year":"52BBY","gender":"male","homeworld":"https://swapi.dev/api/planets/1/","films":["https://swapi.dev/api/films/1/","https://swapi.dev/api/films/5/","https://swapi.dev/api/films/6/"],"species":[],"vehicles":[],"starships":[],"created":"2014-12-10T15:52:14.024000Z","edited":"2014-12-20T21:17:50.317000Z","url":"https://swapi.dev/api/people/6/"},{"name":"Beru Whitesun lars","height":"165","mass":"75","hair_color":"brown","skin_color":"light","eye_color":"blue","birth_year":"47BBY","gender":"female","homeworld":"https://swapi.dev/api/planets/1/","films":["https://swapi.dev/api/films/1/","https://swapi.dev/api/films/5/","https://swapi.dev/api/films/6/"],"species":[],"vehicles":[],"starships":[],"created":"2014-12-10T15:53:41.121000Z","edited":"2014-12-20T21:17:50.319000Z","url":"https://swapi.dev/api/people/7/"},{"name":"R5-D4","height":"97","mass":"32","hair_color":"n/a","skin_color":"white, red","eye_color":"red","birth_year":"unknown","gender":"n/a","homeworld":"https://swapi.dev/api/planets/1/","films":["https://swapi.dev/api/films/1/"],"species":["https://swapi.dev/api/species/2/"],"vehicles":[],"starships":[],"created":"2014-12-10T15:57:50.959000Z","edited":"2014-12-20T21:17:50.321000Z","url":"https://swapi.dev/api/people/8/"},{"name":"Biggs Darklighter","height":"183","mass":"84","hair_color":"black","skin_color":"light","eye_color":"brown","birth_year":"24BBY","gender":"male","homeworld":"https://swapi.dev/api/planets/1/","films":["https://swapi.dev/api/films/1/"],"species":[],"vehicles":[],"starships":["https://swapi.dev/api/starships/12/"],"created":"2014-12-10T15:59:50.509000Z","edited":"2014-12-20T21:17:50.323000Z","url":"https://swapi.dev/api/people/9/"},{"name":"Obi-Wan Kenobi","height":"182","mass":"77","hair_color":"auburn, white","skin_color":"fair","eye_color":"blue-gray","birth_year":"57BBY","gender":"male","homeworld":"https://swapi.dev/api/planets/20/","films":["https://swapi.dev/api/films/1/","https://swapi.dev/api/films/2/","https://swapi.dev/api/films/3/","https://swapi.dev/api/films/4/","https://swapi.dev/api/films/5/","https://swapi.dev/api/films/6/"],"species":[],"vehicles":["https://swapi.dev/api/vehicles/38/"],"starships":["https://swapi.dev/api/starships/48/","https://swapi.dev/api/starships/59/","https://swapi.dev/api/starships/64/","https://swapi.dev/api/starships/65/","https://swapi.dev/api/starships/74/"],"created":"2014-12-10T16:16:29.192000Z","edited":"2014-12-20T21:17:50.325000Z","url":"https://swapi.dev/api/people/10/"}]}'))
      .results;

  List<Planet> planetas = PlanetResponse.fromJson(jsonDecode(
          '{"count":60,"next":"https://swapi.dev/api/planets/?page=2&format=json","previous":null,"results":[{"name":"Tatooine","rotation_period":"23","orbital_period":"304","diameter":"10465","climate":"arid","gravity":"1 standard","terrain":"desert","surface_water":"1","population":"200000","residents":["https://swapi.dev/api/people/1/","https://swapi.dev/api/people/2/","https://swapi.dev/api/people/4/","https://swapi.dev/api/people/6/","https://swapi.dev/api/people/7/","https://swapi.dev/api/people/8/","https://swapi.dev/api/people/9/","https://swapi.dev/api/people/11/","https://swapi.dev/api/people/43/","https://swapi.dev/api/people/62/"],"films":["https://swapi.dev/api/films/1/","https://swapi.dev/api/films/3/","https://swapi.dev/api/films/4/","https://swapi.dev/api/films/5/","https://swapi.dev/api/films/6/"],"created":"2014-12-09T13:50:49.641000Z","edited":"2014-12-20T20:58:18.411000Z","url":"https://swapi.dev/api/planets/1/"},{"name":"Alderaan","rotation_period":"24","orbital_period":"364","diameter":"12500","climate":"temperate","gravity":"1 standard","terrain":"grasslands, mountains","surface_water":"40","population":"2000000000","residents":["https://swapi.dev/api/people/5/","https://swapi.dev/api/people/68/","https://swapi.dev/api/people/81/"],"films":["https://swapi.dev/api/films/1/","https://swapi.dev/api/films/6/"],"created":"2014-12-10T11:35:48.479000Z","edited":"2014-12-20T20:58:18.420000Z","url":"https://swapi.dev/api/planets/2/"},{"name":"Yavin IV","rotation_period":"24","orbital_period":"4818","diameter":"10200","climate":"temperate, tropical","gravity":"1 standard","terrain":"jungle, rainforests","surface_water":"8","population":"1000","residents":[],"films":["https://swapi.dev/api/films/1/"],"created":"2014-12-10T11:37:19.144000Z","edited":"2014-12-20T20:58:18.421000Z","url":"https://swapi.dev/api/planets/3/"},{"name":"Hoth","rotation_period":"23","orbital_period":"549","diameter":"7200","climate":"frozen","gravity":"1.1 standard","terrain":"tundra, ice caves, mountain ranges","surface_water":"100","population":"unknown","residents":[],"films":["https://swapi.dev/api/films/2/"],"created":"2014-12-10T11:39:13.934000Z","edited":"2014-12-20T20:58:18.423000Z","url":"https://swapi.dev/api/planets/4/"},{"name":"Dagobah","rotation_period":"23","orbital_period":"341","diameter":"8900","climate":"murky","gravity":"N/A","terrain":"swamp, jungles","surface_water":"8","population":"unknown","residents":[],"films":["https://swapi.dev/api/films/2/","https://swapi.dev/api/films/3/","https://swapi.dev/api/films/6/"],"created":"2014-12-10T11:42:22.590000Z","edited":"2014-12-20T20:58:18.425000Z","url":"https://swapi.dev/api/planets/5/"},{"name":"Bespin","rotation_period":"12","orbital_period":"5110","diameter":"118000","climate":"temperate","gravity":"1.5 (surface), 1 standard (Cloud City)","terrain":"gas giant","surface_water":"0","population":"6000000","residents":["https://swapi.dev/api/people/26/"],"films":["https://swapi.dev/api/films/2/"],"created":"2014-12-10T11:43:55.240000Z","edited":"2014-12-20T20:58:18.427000Z","url":"https://swapi.dev/api/planets/6/"},{"name":"Endor","rotation_period":"18","orbital_period":"402","diameter":"4900","climate":"temperate","gravity":"0.85 standard","terrain":"forests, mountains, lakes","surface_water":"8","population":"30000000","residents":["https://swapi.dev/api/people/30/"],"films":["https://swapi.dev/api/films/3/"],"created":"2014-12-10T11:50:29.349000Z","edited":"2014-12-20T20:58:18.429000Z","url":"https://swapi.dev/api/planets/7/"},{"name":"Naboo","rotation_period":"26","orbital_period":"312","diameter":"12120","climate":"temperate","gravity":"1 standard","terrain":"grassy hills, swamps, forests, mountains","surface_water":"12","population":"4500000000","residents":["https://swapi.dev/api/people/3/","https://swapi.dev/api/people/21/","https://swapi.dev/api/people/35/","https://swapi.dev/api/people/36/","https://swapi.dev/api/people/37/","https://swapi.dev/api/people/38/","https://swapi.dev/api/people/39/","https://swapi.dev/api/people/42/","https://swapi.dev/api/people/60/","https://swapi.dev/api/people/61/","https://swapi.dev/api/people/66/"],"films":["https://swapi.dev/api/films/3/","https://swapi.dev/api/films/4/","https://swapi.dev/api/films/5/","https://swapi.dev/api/films/6/"],"created":"2014-12-10T11:52:31.066000Z","edited":"2014-12-20T20:58:18.430000Z","url":"https://swapi.dev/api/planets/8/"},{"name":"Coruscant","rotation_period":"24","orbital_period":"368","diameter":"12240","climate":"temperate","gravity":"1 standard","terrain":"cityscape, mountains","surface_water":"unknown","population":"1000000000000","residents":["https://swapi.dev/api/people/34/","https://swapi.dev/api/people/55/","https://swapi.dev/api/people/74/"],"films":["https://swapi.dev/api/films/3/","https://swapi.dev/api/films/4/","https://swapi.dev/api/films/5/","https://swapi.dev/api/films/6/"],"created":"2014-12-10T11:54:13.921000Z","edited":"2014-12-20T20:58:18.432000Z","url":"https://swapi.dev/api/planets/9/"},{"name":"Kamino","rotation_period":"27","orbital_period":"463","diameter":"19720","climate":"temperate","gravity":"1 standard","terrain":"ocean","surface_water":"100","population":"1000000000","residents":["https://swapi.dev/api/people/22/","https://swapi.dev/api/people/72/","https://swapi.dev/api/people/73/"],"films":["https://swapi.dev/api/films/5/"],"created":"2014-12-10T12:45:06.577000Z","edited":"2014-12-20T20:58:18.434000Z","url":"https://swapi.dev/api/planets/10/"}]}'))
      .results;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            Container(
              height: 270,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: personas.length,
                itemBuilder: (context, index) {
                  List<String> personajes =
                      personas.elementAt(index).url.split('/');
                  String idFoto = personajes[5];

                  return Container(
                    width: 160,
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
                                      child:
                                          Text(personas.elementAt(index).name),
                                    ),
                                  ],
                                ),
                              ))),
                    ),
                  );
                },
              ),
            ),
            Container(
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: personas.length,
                    itemBuilder: (context, index) {
                      List<String> planetass =
                          planetas.elementAt(index).url.split('/');
                      String idPlaneta = planetass[5];

                      return Container(
                        width: 160,
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
                                          child: Text(
                                              planetas.elementAt(index).name),
                                        ),
                                      ],
                                    ),
                                  ))),
                        ),
                      );
                    }))
          ],
        ),
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

  Widget _planetItem(Planet planet) {
    List<String> planetas = planet.url.split('/');
    String idPlaneta = planetas[5];
    return Container(
      width: 160,
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
      width: 160,
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

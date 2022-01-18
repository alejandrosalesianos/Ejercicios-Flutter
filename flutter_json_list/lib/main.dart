import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_json_list/models/pokemon-response.dart';
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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Pokemon>> pokemons;

  @override
  void initState() {
    pokemons = fetchPokemon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FutureBuilder<List<Pokemon>>(
        future: pokemons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _pokemonList(snapshot.data!);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    ));
  }

  Future<List<Pokemon>> fetchPokemon() async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return PokemonResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Widget _pokemonList(List<Pokemon> pokemonList) {
    return ListView.builder(
      itemCount: pokemonList.length,
      itemBuilder: (context, index) {
        return _pokemonItem(pokemonList.elementAt(index));
      },
    );
  }

  Widget _pokemonItem(Pokemon pokemon) {
    return Card(
      child: Text(pokemon.name),
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigation/models/amiibo.dart';

class Pokemon extends StatefulWidget {
  const Pokemon({Key? key}) : super(key: key);

  @override
  _PokemonState createState() => _PokemonState();
}

class _PokemonState extends State<Pokemon> {
  late Future<List<Amiibo>> amiiboList;

  @override
  void initState() {
    amiiboList = fetchAmiibo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Amiibo>>(
        future: amiiboList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _amiiboList(snapshot.data!);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const Center(child: CircularProgressIndicator());
        });
  }

  Future<List<Amiibo>> fetchAmiibo() async {
    final response = await http.get(
        Uri.parse('https://www.amiiboapi.com/api/amiibo/?gameseries=0x190'));
    if (response.statusCode == 200) {
      return AmiiboResponse.fromJson(jsonDecode(response.body)).amiibo;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Widget _amiiboList(List<Amiibo> amiiboList) {
    return SizedBox(
      height: 450,
      width: 350,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: amiiboList.length,
        itemBuilder: (context, index) {
          return _amiiboItem(amiiboList.elementAt(index), index);
        },
      ),
    );
  }

  Widget _amiiboItem(Amiibo amiibo, int index) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        width: 150,
        child: Card(
          child: InkWell(
            splashColor: Colors.red.withAlpha(30),
            onTap: () {
              debugPrint('Card tapped.');
            },
            child: SizedBox(
              width: 300,
              height: 200,
              child: Column(
                children: [
                  Text(amiibo.name),
                  Image.network(
                    amiibo.image,
                    width: 200,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/pokemon');
                      },
                      child: Text('Detalles'))
                ],
              ),
            ),
          ),
        ));
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_themoviedb/models/popular_movie.dart';
import 'package:flutter_themoviedb/models/upcoming_movie.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<PopularMovie>> populares;
  late Future<List<UpcomingMovie>> upcoming;

  @override
  void initState() {
    populares = fetchPopular();
    upcoming = fetchUpcoming();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/img/FotoPerfil.jpg'),
                              fit: BoxFit.fill),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Alejandro Martin',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://static.thenounproject.com/png/2629729-200.png'),
                        fit: BoxFit.fill),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                'Movie, Series,\nTV Shows...',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[150]),
                    child: Row(
                      children: const [
                        Icon(Icons.search),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text('Buscar'),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: const Icon(
                      Icons.menu,
                      size: 24,
                    ),
                    padding: EdgeInsets.all(16),
                    shape: CircleBorder(),
                  )
                ],
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Newest',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            Container(
              height: 275,
              child: Center(
                  child: FutureBuilder<List<UpcomingMovie>>(
                future: upcoming,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _upcomingList(snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              )),
            ),
            Container(
              height: 275,
              child: Center(
                  child: FutureBuilder<List<PopularMovie>>(
                future: populares,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _popularList(snapshot.data!);
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
    );
  }

  Future<List<UpcomingMovie>> fetchUpcoming() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=230fc17880d7d6f7d98b554ff0ba9294'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return UpcomingResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<PopularMovie>> fetchPopular() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=230fc17880d7d6f7d98b554ff0ba9294'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return PopularResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Widget _popularList(List<PopularMovie> popularList) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: popularList.length,
      itemBuilder: (context, index) {
        return _popularItem(popularList.elementAt(index));
      },
    );
  }

  Widget _upcomingList(List<UpcomingMovie> upcomingList) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: upcomingList.length,
      itemBuilder: (context, index) {
        return _upcomingItem(upcomingList.elementAt(index));
      },
    );
  }

  Widget _popularItem(PopularMovie popularMovie) {
    return SizedBox(
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
                            'https://www.themoviedb.org/t/p/original/${popularMovie.posterPath}'),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(popularMovie.title),
                      ),
                    ],
                  ),
                ))),
      ),
    );
  }

  Widget _upcomingItem(UpcomingMovie upcomingMovie) {
    return SizedBox(
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
                            'https://www.themoviedb.org/t/p/original/${upcomingMovie.posterPath}'),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(upcomingMovie.title),
                      ),
                    ],
                  ),
                ))),
      ),
    );
  }
}

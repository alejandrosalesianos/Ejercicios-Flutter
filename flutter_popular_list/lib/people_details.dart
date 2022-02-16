import 'package:flutter/material.dart';
import 'package:flutter_popular_list/model/popular_response.dart';

class PeopleDetails extends StatefulWidget {
  const PeopleDetails({Key? key}) : super(key: key);

  @override
  _PeopleDetailsState createState() => _PeopleDetailsState();
}

class _PeopleDetailsState extends State<PeopleDetails> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Results;
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.network(
            'https://image.tmdb.org/t/p/w500${args.profilePath}',
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80, left: 30),
          child: FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              }),
        ),
        ListView.builder(
            itemCount: args.knownFor?.length,
            itemBuilder: (context, index) {
              return knowForList(args.knownFor!);
            })
      ],
    ));
  }

  Widget knowForItem(KnownFor knownFor) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: 100,
        height: 300,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                  'https://image.tmdb.org/t/p/w500${knownFor.posterPath}'),
            ),
            Text(
              '${knownFor.title}',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '${knownFor.releaseDate}',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Widget knowForList(List<KnownFor> knownForList) {
    return Padding(
      padding: const EdgeInsets.only(top: 400),
      child: SizedBox(
        width: 300,
        height: 300,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: knownForList.length,
            itemBuilder: (context, index) {
              return knowForItem(knownForList.elementAt(index));
            }),
      ),
    );
  }
}

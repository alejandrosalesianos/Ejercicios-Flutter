import 'package:flutter/material.dart';
import 'package:flutter_card/style.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Card(
                child: InkWell(
                  splashColor: Colors.orange.withAlpha(30),
                  onTap: () {
                    debugPrint('Card tapped.');
                  },
                  child: SizedBox(
                    width: 350,
                    height: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, left: 10),
                                child: RichText(
                                    text: const TextSpan(
                                        text: '20:55\n',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                        children: [
                                      TextSpan(
                                          text: 'SALIDA',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10))
                                    ])),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 90, left: 10),
                                child: RichText(
                                    text: const TextSpan(
                                        text: '22:05\n',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                        children: [
                                      TextSpan(
                                          text: 'LLEGADA',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10))
                                    ])),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, right: 130),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(15.0),
                                    padding: const EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(2)),
                                    child: RichText(
                                        text: const TextSpan(
                                            text: 'MAD',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14))),
                                  ),
                                  RichText(
                                      text: const TextSpan(
                                          text: 'Madrid',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18)))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 130),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset('assets/images/iberia.png', width: 50,),
                                      RichText(
                                                text: const TextSpan(
                                                    text: 'Iberia 7448',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 13),
                                                        )),
                                    ],
                                  ),
                                  RichText(
                                                text: const TextSpan(
                                                    text: 'Duración 2h 10m',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 13)))
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, right: 130),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(15.0),
                                    padding: const EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(2)),
                                    child: RichText(
                                        text: const TextSpan(
                                            text: 'LHR',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14))),
                                  ),
                                  RichText(
                                      text: const TextSpan(
                                          text: 'Londres',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18)))
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

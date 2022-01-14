import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: Card(
                child: InkWell(
                  onTap: () {
                    debugPrint('Card tapped.');
                  },
                  child: SizedBox(
                    width: 500,
                    height: 450,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(top: 25, left: 20),
                                child: RichText(
                                    text: const TextSpan(
                                  text: 'El mas barato,Buena puntuación',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ))),
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: RichText(
                                text: const TextSpan(
                                    text: '45 ofertas',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )
                          ],
                        ),
                        Image.asset(
                          'assets/images/car.png',
                          width: 300,
                          height: 200,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              RichText(
                                  text: const TextSpan(
                                      text: 'Mini\n',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                      children: [
                                    TextSpan(
                                        text:
                                            '2 puertas · BMW UwU Diesel o similar\n',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14)),
                                  ])),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Container(
                                    child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/marcha.png',
                                      width: 21.5,
                                      height: 21.5,
                                    ),
                                    Text('Man')
                                  ],
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Container(
                                    child: Row(
                                  children: const [
                                    Icon(
                                      Icons.ac_unit,
                                    ),
                                    Text('A/A')
                                  ],
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Container(
                                    child: Row(
                                  children: const [
                                    Icon(
                                      Icons.person,
                                    ),
                                    Text('4')
                                  ],
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Container(
                                    child: Row(
                                  children: const [
                                    Icon(
                                      Icons.business_center,
                                    ),
                                    Text('1')
                                  ],
                                )),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, left: 20),
                                child: RichText(
                                    text: const TextSpan(
                                  text: '42069€',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 34),
                                ))),
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: RichText(
                                text: const TextSpan(
                                    text: 'SELECCIONAR',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 24)),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

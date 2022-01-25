import 'package:flutter/material.dart';

void main() => runApp(const Onboarding());

class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);

  static const String _title = 'el titulo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/img/logoLogin.png',
                    width: 300,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: SizedBox(
                width: 250,
                child: Container(
                    alignment: Alignment.topCenter,
                    child: const Text(
                      'Descubre tu trabajo soñado',
                      style: TextStyle(fontSize: 30),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: SizedBox(
                width: 300,
                child: Container(
                    alignment: Alignment.topCenter,
                    child: const Text(
                      'Explora todo tipo de trabajos basado en tus gustos',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Center(
                child: SizedBox(
                    width: 350,
                    height: 70,
                    child: Stack(
                      children: [
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(1, 1, 1, 0.3),
                            ),
                          ),
                          onTap: () {},
                        ),
                        Container(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, right: 40),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: Text(
                                  'Loguearse',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.red),
                                ),
                              ),
                            )),
                        InkWell(
                            child: SizedBox(
                                width: 170,
                                height: 70,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromRGBO(250, 250, 250, 0.7),
                                  ),
                                )),
                            onTap: () {}),
                        Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, left: 30),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: Text(
                                  'Registrarse',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.red),
                                ),
                              ),
                            )),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

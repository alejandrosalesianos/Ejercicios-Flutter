import 'package:flutter/material.dart';
import 'package:flutter_weather_project/pages/mapa.dart';
import 'package:flutter_weather_project/styles/styles.dart';

class InitPage extends StatefulWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Bienvenido a la aplicacion del tiempo.\n ¿De dónde es usted?',
                  style: Styles.welcome,
                ),
              ),
              Mapa(),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/menu');
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      color: Styles.container,
                      child: Padding(
                        padding: EdgeInsets.only(left: 25, top: 5),
                        child: Text(
                          'Seleccionar',
                          style: Styles.textCiudad,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

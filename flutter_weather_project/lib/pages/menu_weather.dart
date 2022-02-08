import 'package:flutter/material.dart';
import 'package:flutter_weather_project/pages/earth_weather.dart';
import 'package:flutter_weather_project/pages/mapa.dart';
import 'package:flutter_weather_project/styles/styles.dart';

class MenuNavigator extends StatefulWidget {
  const MenuNavigator({Key? key}) : super(key: key);

  @override
  _MenuNavigatorState createState() => _MenuNavigatorState();
}

class _MenuNavigatorState extends State<MenuNavigator> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    EarthWeatherPage(),
    Mapa(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.background,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'El tiempo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rcapp/pages/Booking.dart';
import 'package:rcapp/pages/Food.dart';
import 'package:rcapp/pages/Home.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    Food(),
    Booking(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.deepOrange,
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            backgroundColor: Colors.deepOrange,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood),
              title: Text('Food'),
              backgroundColor: Colors.deepOrange,
              activeIcon: Icon(Icons.fastfood, color: Colors.deepOrange),
    ),
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              title: Text('Booking'),
              backgroundColor: Colors.deepOrange,
          ),
        ],
      ),
    );
  }
}

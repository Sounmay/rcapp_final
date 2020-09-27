import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rcapp/pages/Booking.dart';
import 'package:rcapp/pages/CategoryMenuList/flushbar.dart';
import 'package:rcapp/pages/Food.dart';
import 'package:rcapp/pages/Home.dart';
import 'package:provider/provider.dart';
import 'package:rcapp/pages/storeData.dart';

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

  register() async {
    final fbm = FirebaseMessaging();
    var token = await fbm.getToken();
    print('this is token ::: ' + '$token');
    var admin = await Firestore.instance
        .collection('userInfo')
        .where('isAdmin', isEqualTo: true)
        .getDocuments();
    var admintoken = [];
    admin.documents.forEach((element) {
      admintoken.add(element["token"].toString());
    });
    print(admintoken);
  }

  Future configure() async {
    final fbm = FirebaseMessaging();
    fbm.configure(onMessage: (msg) {
      print(msg);
      showFlushbarNotification(
          context, msg['notification']['title'], msg['notification']['body']);
      return;
    }, onLaunch: (msg) {
      print(msg);
      return;
    }, onResume: (msg) {
      print(msg);
      return;
    });
  }

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    configure();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => StoreData(),
      child: Scaffold(
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
      ),
    );
  }
}

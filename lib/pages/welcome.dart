import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class welcome extends StatefulWidget {
  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  Future configure() async {
    final fbm = FirebaseMessaging();
    fbm.configure(onMessage: (msg) {
      print(msg);
      return;
    }, onLaunch: (msg) {
      print(msg);
      return;
    }, onResume: (msg) {
      print(msg);
      return;
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
    Future.delayed(Duration(seconds: 1), () {
      Navigator.popAndPushNamed(context, '/wrapper');
    });
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: new ListView(
        children: [
          Image(image: AssetImage('assets/rclogo.png')),
          Center(
            child: Text(
              'ROURKELA CLUB',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 40.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

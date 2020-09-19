import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class welcome extends StatefulWidget {
  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
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

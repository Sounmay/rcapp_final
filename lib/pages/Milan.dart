import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MilanLounge extends StatefulWidget {
  @override
  _MilanLoungeState createState() => _MilanLoungeState();
}

class _MilanLoungeState extends State<MilanLounge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: Colors.deepOrange,
        title: Text('Blue Lounge'),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            child: Container(
              height: 200.0,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  image: DecorationImage(
                      image: new AssetImage("assets/18.jpg"),
                      fit: BoxFit.fill)),
            ),
          ),
          Text(
            "Milan Lounge",
            style: GoogleFonts.inter(
              color: Colors.blueAccent,
              fontSize: 40,
            ),
          ),
          Text(
            "The Milan Lounge is a cozy lounge. Perfect for small group gatherings like office parties, get togethers amongst friends etc \n \nCapacity : 15 people\n \n \n \n ",
            style: GoogleFonts.inter(
                fontSize: 20
            ),
          ),
          SizedBox(
              width: double.infinity,
              height: 60,
              child: ButtonTheme(
                child: RaisedButton(
                    color: Colors.deepOrange,
                    onPressed: () {
                      Navigator.pushNamed(context, "/bookingcalendar");
                    },
                    child: Text('Book',
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 18))),
              )),
        ],
      ),
    );  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MainHall extends StatefulWidget {
  @override
  _MainHallState createState() => _MainHallState();
}

class _MainHallState extends State<MainHall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: Colors.deepOrange,
        title: Text('Main Recption Hall'),
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
                      image: new AssetImage("assets/15.jpg"),
                      fit: BoxFit.fill)),
            ),
          ),
          Text("The Main Banquet Hall",
            style: GoogleFonts.inter(
                color: Colors.redAccent,
                fontSize: 30
            ),),
          Container(
            padding: EdgeInsets.all(10),
            child:Text("Present in front of the entrance, the main Banquet Hall is for major occasion s and for big group gatherings, such as musical events, social gatherings, large office parties, marriage receptions, etc \n \n"
                "Capacity - 250 people",
              style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 20
              ),),
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
    );
  }
}

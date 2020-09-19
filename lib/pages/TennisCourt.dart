import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TennisCourt extends StatefulWidget {
  @override
  _TennisCourtState createState() => _TennisCourtState();
}

class _TennisCourtState extends State<TennisCourt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: Colors.deepOrange,
        title: Text('Tennis Court'),
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
                      image: new AssetImage("assets/51.jpg"),
                      fit: BoxFit.fill)),
            ),
          ),
          Text("Tennis Court",
            style: GoogleFonts.inter(
                color: Colors.green,
                fontSize: 30
            ),),
          Container(
            padding: EdgeInsets.all(10),
            child:Text("The Open Tennis court is perfect for sporting events, and for large group gettogethers like Anniversaries, Birthdays, Office picnics etc \n \n"
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
    );  }
}

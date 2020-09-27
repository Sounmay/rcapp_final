import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeddingHall extends StatefulWidget {
  @override
  _WeddingHallState createState() => _WeddingHallState();
}

class _WeddingHallState extends State<WeddingHall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: Colors.deepOrange,
        title: Text('Banquets'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        child: new Column(
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
                        image: new AssetImage("assets/16.jpg"),
                        fit: BoxFit.fill)),
              ),
            ),
            Text(
              "Wedding Reception Hall",
              style: GoogleFonts.inter(
                  color: Colors.blueGrey,
                  fontSize: MediaQuery.of(context).size.width * 0.075),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "Located near the swimming pool area, the wedding reception hall is meant for big gatherings in occasions like marriages, receptions, birthday parties etc. \n \n"
                "Capacity - 250 people",
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.05),
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
                          style: GoogleFonts.inter(
                              color: Colors.white, fontSize: 18))),
                )),
          ],
        ),
      ),
    );
  }
}

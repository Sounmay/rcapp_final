import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MilapLounge extends StatefulWidget {
  @override
  _MilapLoungeState createState() => _MilapLoungeState();
}

class _MilapLoungeState extends State<MilapLounge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: Colors.deepOrange,
        title: Text('Lounges'),
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
                        image: new AssetImage("assets/17.jpg"),
                        fit: BoxFit.fill)),
              ),
            ),
            Text(
              "Milap Reception Hall",
              style: GoogleFonts.inter(
                color: Colors.blueAccent,
                fontSize: MediaQuery.of(context).size.width * 0.075,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: Text(
                " \nThe Milap Reception Hall is a large hall present in the first floor of the club. Perfect for medium group gatherings like office parties, departmental dinners etc \n \nCapacity : 70 people\n \n ",
                style: GoogleFonts.inter(fontSize: MediaQuery.of(context).size.width*0.05),
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

import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rcapp/pages/NavigationBar.dart';

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 10.0,
        backgroundColor: Colors.deepOrange,
        title: Container(
          margin:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.13),
          child: Text('Booking', style: GoogleFonts.inter()),
        ), //repeat for menu and booking
      ),
      body: new ListView(
        children: <Widget>[
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                " Lounges",
                style: GoogleFonts.inter(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              OutlineButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/bookingcalendar');
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  color: Colors.grey,
                  child: Text('Calendar')),
            ],
          ),
          SizedBox(height: 10.0),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              height: 150.0,
              width: double.infinity,
              child: new Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/bluelounge");
                          },
                          child: Container(
                            height: 100.0,
                            width: 150.0,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'Blue Lounge',
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                                image: DecorationImage(
                                    image: new AssetImage("assets/12.jpg"),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/yellowlounge");
                          },
                          child: Container(
                            height: 100.0,
                            width: 150.0,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'Yellow Lounge',
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                                image: DecorationImage(
                                    image: new AssetImage("assets/13.jpg"),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/milaplounge");
                          },
                          child: Container(
                            height: 100.0,
                            width: 150.0,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'Milap Hall',
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                                image: DecorationImage(
                                    image: new AssetImage("assets/17.jpg"),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/milanlounge");
                          },
                          child: Container(
                            height: 100.0,
                            width: 150.0,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'Milan Lounge',
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                                image: DecorationImage(
                                    image: new AssetImage("assets/18.jpg"),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/mainhall");
                          },
                          child: Container(
                            height: 100.0,
                            width: 150.0,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'Main Hall',
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                                image: DecorationImage(
                                    image: new AssetImage("assets/15.jpg"),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              )),
          SizedBox(height: 30.0),
          Text(
            " Banquet Halls",
            style: GoogleFonts.inter(
              color: Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.0),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              height: 150.0,
              width: double.infinity,
              child: new Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/weddinghall");
                          },
                          child: Container(
                            height: 100.0,
                            width: 150.0,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'Wedding Hall',
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                                image: DecorationImage(
                                    image: new AssetImage("assets/16.jpg"),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/tenniscourt");
                          },
                          child: Container(
                            height: 100.0,
                            width: 150.0,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'Tennis Court',
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                                image: DecorationImage(
                                    image: new AssetImage("assets/51.jpg"),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              )),
        ],
      ),
    );
  }
}

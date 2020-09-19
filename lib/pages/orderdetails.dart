import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';


class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 10.0,
          backgroundColor: Colors.deepOrange,
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Order Details'),
              ])
      ),
      body: new ListView(
        children: <Widget>[
          SizedBox(height: 20.0),
          Container(
            alignment: Alignment.topLeft,
            height: 530.0,
            width: 90.0,
            margin: new EdgeInsets.only(left: 20.0, right:20.0),
            decoration: BoxDecoration(
              color: Colors.tealAccent,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child:  Text(
                        "Order Number : " + "111",
                        style: GoogleFonts.inter(color: Colors.deepOrange, fontSize: 22),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child:Text(
                          "Aug 4th 2020"
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child:  Text(
                        "Name : " + "Aswin Kumar Raju",
                        style: GoogleFonts.inter(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child:  Text(
                        "Personal No. : " + "999999",
                        style: GoogleFonts.inter(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

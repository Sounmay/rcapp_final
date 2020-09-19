import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rcapp/pages/Food.dart';



class OrderCard extends StatefulWidget {
  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
            child: new Container(
              alignment: Alignment.centerLeft,
              height: 100.0,
              width: 90.0,
              margin: new EdgeInsets.only(left: 20.0, right:20.0),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
                child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Total Amount:",
                            style: GoogleFonts.inter(color: Colors.white, fontSize: 22),
                          ),
                          Text(
                            "₹80",
                            style: GoogleFonts.inter(color: Colors.white, fontSize: 22),
                          ),
                        ],
                ),
                )
            );
  }
}

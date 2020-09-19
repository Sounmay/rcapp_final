import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderCard extends StatefulWidget {
  int total;
  OrderCard({this.total});
  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          height: 60.0,
          // width: 180.0,
          margin: new EdgeInsets.only(left: 20.0, right: 20.0),
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: new Center(
              child: new Text(
                "Total Amount: " + '${widget.total}',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 22),
              ))),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddFood extends StatefulWidget {
  final String id;
  final String Name;
  final double price;
  @override
  _AddFoodState createState() => _AddFoodState();
  AddFood({this.id, this.Name, this.price});
}

class _AddFoodState extends State<AddFood> {

  int FQty = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.radio_button_checked,
                    color: Colors.green,
                  ),
                ),
                Text(
                  widget.Name,
                  style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.remove,
                  ),
                  onPressed: () {
                    setState(() {
                      if (FQty > 0) {
                        FQty -= 1;
                      }
                    });
                  },
                ),
                Text(
                  '$FQty',
                  style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add,
                  ),
                  onPressed: () {
                    setState(() {
                      FQty += 1;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              margin: new EdgeInsets.symmetric(horizontal:50.0),
              child:Text(
                '₹' + widget.price.toString(),
                style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        const Divider(
          color: Colors.grey,
          height: 2,
          thickness: 1,
          indent: 5,
          endIndent: 5,
        ),
      ],
    );
  }
}

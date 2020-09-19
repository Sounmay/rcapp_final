import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rcapp/services/database.dart';

class MenuCard extends StatelessWidget {
  final String categoryName;
  final String imagePath;
  final int index;

  MenuCard({this.categoryName, this.imagePath, this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        menu = getPosts(index);
      },
      child: Column(children: <Widget>[
        Container(
          width: 65,
          height: 65,
          margin: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('$imagePath'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(6)),
          child: null,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              '$categoryName',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactDetails extends StatefulWidget {
  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height*1,
          decoration: BoxDecoration(color: Colors.grey[200]),
          child:Column(
            children: <Widget>[
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height*0.22,
                width: MediaQuery.of(context).size.width*0.95,
                decoration: BoxDecoration(color: Colors.white),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  height: MediaQuery.of(context).size.height*0.1,
                  width: MediaQuery.of(context).size.width*0.9,
                  child: Text(
                    "For order related queries, please contact: \n \nMr. Debabrata Mohanty - +919438208969 \n",
                    style: TextStyle(
                        fontSize: 17.5
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      border: Border.all(color: Colors.grey)),

                ),
              ),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height*0.22,
                width: MediaQuery.of(context).size.width*0.95,
                decoration: BoxDecoration(color: Colors.white),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  height: MediaQuery.of(context).size.height*0.1,
                  width: MediaQuery.of(context).size.width*0.9,
                  child: Text(
                    "For booking related queries, please contact: \n \nMr. Pramod Kumar Pattnaik - +919437116141 \n",
                    style: TextStyle(
                        fontSize: 17.5
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      border: Border.all(color: Colors.grey)),

                ),
              ),
            ],
          )
      )
    );
  }
}

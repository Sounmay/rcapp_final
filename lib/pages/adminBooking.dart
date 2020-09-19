import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rcapp/models/event.dart';
import 'package:rcapp/models/user.dart';
import 'package:rcapp/services/database.dart';
import 'package:rcapp/res/event_firestore_service.dart';

class AdminBooking extends StatefulWidget {
  final EventModel note;

  const AdminBooking({Key key, this.note}) : super(key: key);

  @override
  _AdminBookingState createState() => _AdminBookingState();
}

class _AdminBookingState extends State<AdminBooking> {
  List<dynamic> bookings = [];

  String name = '';
  String number = '';
  String lounge = '';
  int slot;
  int documentlength = 1;
  String status = '';

  void initialData() async {
    var result = await Firestore.instance
        .collection('BookingDetails')
        .orderBy('_date', descending: true)
        .getDocuments();
    setState(() {
      documentlength = result.documents.length;
    });
    result.documents.forEach((res) {
      setState(() {
        bookings.add(res.data);
      });
    });
  }

  void rejectBookinHistory(int _eventDate, int index) async {
    await Firestore.instance
        .collection('BookingDetails')
        .document('$_eventDate')
        .delete();
    setState(() {
      bookings.removeAt(index);
    });
  }

  void confirmBooking(
      String _name,
      String _personalno,
      String loungeColor,
      int _slot,
      int numberOfPeople,
      int _eventDate,
      Timestamp _bookingDate,
      int index) async {
    await Firestore.instance
        .collection('BookingDetails')
        .document('$_eventDate')
        .updateData({'isConfirmed': true});
    setState(() {
      bookings[index]["isConfirmed"] = true;
    });
    if (widget.note != null) {
      await eventDBS.updateData(widget.note.id, {
        "name": _name,
        "personal no": _personalno,
        "Lounge": loungeColor,
        "event_date": _bookingDate.toDate(),
        "slot": _slot,
        "numberOfPeople": numberOfPeople
      });
    } else {
      await eventDBS.createItem(EventModel(
          name: _name,
          personalno: _personalno,
          Lounge: loungeColor,
          eventDate: _bookingDate.toDate(),
          slot: _slot,
          numberOfPeople: numberOfPeople));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialData();
  }

  @override
  Widget build(BuildContext context) {
    int orderNo = 110;
    if (bookings.length == 0 && documentlength == 1) {
      return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              SpinKitCircle(color: Colors.deepOrange, size: 65),
              Text('Loading data')
            ])),
      );
    } else if (documentlength == 0) {
      return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Icon(Icons.all_inclusive),
              Text('No data')
            ])),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Your Booking'),
          backgroundColor: Colors.deepOrange,
        ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(color: Colors.grey[200]),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: bookings.length,
            itemBuilder: (_, index) {
              orderNo = 110;
              orderNo += index;
              return ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 240.0,
                      width: 380.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          border: Border.all(color: Colors.grey)),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "#$orderNo",
                                style: GoogleFonts.inter(
                                    color: Colors.deepOrange, fontSize: 22),
                              ),
                              Flexible(
                                  child: Text('${bookings[index]["date"]}')),
                            ],
                          ),
                          SizedBox(height: 8),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Name : " + "${bookings[index]["name"]}",
                                      style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Personal No. : " +
                                          "${bookings[index]["number"]}",
                                      style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Lounge : " +
                                          "${bookings[index]["lounge"]}",
                                      style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Slot: ${bookings[index]["slot"]}',
                                      style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                        bookings[index]["isConfirmed"]
                                            ? 'Status: Confirmed'
                                            : 'Status: Not Confirmed',
                                        style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(width: 30)
                                  ],
                                ),
                                SizedBox(height: 10),
                              ]),
                          if (!bookings[index]["isConfirmed"]) ...[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Container(
                                      height: 30,
                                      width: 110,
                                      child: FlatButton(
                                        onPressed: () {
                                          rejectBookinHistory(
                                              bookings[index]["_date"], index);
                                        },
                                        color: Colors.red[700],
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Icon(
                                                Icons.close,
                                                size: 17,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                'Reject',
                                                style: GoogleFonts.inter(
                                                    color: Colors.white),
                                              ),
                                            ]),
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(8.0)),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      height: 30,
                                      width: 110,
                                      child: FlatButton(
                                        onPressed: () {
                                          confirmBooking(
                                              bookings[index]["name"],
                                              bookings[index]["number"],
                                              bookings[index]["lounge"],
                                              bookings[index]["slot"],
                                              bookings[index]["numberOfPeople"],
                                              bookings[index]["_date"],
                                              bookings[index]["bookingDate"],
                                              index);
                                        },
                                        color: Colors.deepOrange,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Icon(
                                                Icons.check,
                                                size: 17,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                'Confirm',
                                                style: GoogleFonts.inter(
                                                    color: Colors.white),
                                              ),
                                            ]),
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(8.0)),
                                      ),
                                    )
                                  ]),
                                ]),
                          ] else ...[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    height: 30,
                                    width: 100,
                                    child: FlatButton(
                                      onPressed: () {
                                        rejectBookinHistory(
                                            bookings[index]["_date"], index);
                                      },
                                      color: Colors.red[700],
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon(
                                              Icons.delete,
                                              size: 17,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              'Delete',
                                              style: GoogleFonts.inter(
                                                  color: Colors.white),
                                            ),
                                          ]),
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(8.0)),
                                    ),
                                  )
                                ])
                          ],
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    }
  }
}

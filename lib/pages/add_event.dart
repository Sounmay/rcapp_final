import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rcapp/models/event.dart';
import 'package:flutter/material.dart';
import 'package:rcapp/pages/CategoryMenuList/flushbar.dart';
import 'package:rcapp/pages/customAlert.dart';
import 'package:rcapp/res/event_firestore_service.dart';
import 'package:rcapp/services/database.dart';

class AddEventPage extends StatefulWidget {
  final EventModel note;

  const AddEventPage({Key key, this.note}) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseService _booking = DatabaseService();

  String _name = '';
  String _personalno = '';
  String _mobileno = '';
  int slot = 1;
  DateTime _eventDate;
  int numberOfPeople = 1;
  int _value1 = 1;
  int _value2 = 1;
  bool exits = false;

  var id;
  bool processing;

  List<String> loungeColor = [
    'Yellow',
    'Red',
    'Blue',
    'Milan',
    'Milap Hall',
    'Main Banquet',
    'Wedding Banquet'
  ];

  void initialize() async {
    var uid = (await FirebaseAuth.instance.currentUser()).uid;
    var data =
        await Firestore.instance.collection('userInfo').document(uid).get();
    setState(() {
      id = uid;
      _name = data.data["name"];
      _personalno = data.data["number"];
    });
  }

  void confirmBooking() async {
    String _eventDatestring = '${_eventDate.day}' +
        '/' +
        '${_eventDate.month}' +
        '/' +
        '${_eventDate.year}';
    print(_eventDatestring);
    var result = await Firestore.instance
        .collection('BookingDetails')
        .where('date', isEqualTo: _eventDatestring)
        .getDocuments();
    result.documents.forEach((element) {
      if (loungeColor[_value1 - 1] == element.data["lounge"] &&
          slot == element.data["slot"]) {
        setState(() {
          exits = true;
        });
      }
    });
    if (!exits) {
      _booking.bookDetails(id, _name, _personalno, _mobileno, numberOfPeople,
          loungeColor[_value1 - 1], slot, _eventDate);
      showDialog(
          context: context,
          builder: (context) => CustomAlert(
                title: 'Booking Requested',
                description:
                    'Your booking request has been forwarded to the administrator. You will get a confirmation notification within 24 hours and can view your booking in the calendar. For further queries, please contact - Mr. Pramod Kumar Pattnaik - +919437116141',
                /*url: 'assets/tick.gif',*/
              ));

      // Navigator.pop(context);
    } else {
      showFlushbarBooking(context);
      setState(() {
        exits = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _eventDate = DateTime.now();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    if (_name == '' && _personalno == '') {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.note != null ? "Edit Note" : "Booking Details"),
          elevation: 10.0,
          backgroundColor: Colors.deepOrange,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: SpinKitCircle(color: Colors.deepOrange),
              )
            ]),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.note != null ? "Edit Note" : "Booking Details"),
          elevation: 10.0,
          backgroundColor: Colors.deepOrange,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: false,
              children: <Widget>[
                TextFormField(
                    initialValue: '$_name',
                    decoration: InputDecoration(
                        hintText: 'Name',
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 1.0),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 3.0),
                            borderRadius: BorderRadius.circular(10))),
                    validator: (val) => val.isEmpty ? 'Enter your Name' : null,
                    onChanged: (val) {
                      setState(() => _name = val);
                    }),
                SizedBox(height: 10),
                TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: _personalno,
                    decoration: InputDecoration(
                        hintText: 'Personal No.',
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 1.0),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 3.0),
                            borderRadius: BorderRadius.circular(10))),
                    validator: (val) =>
                        val.isEmpty ? 'Enter your Personal No.' : null,
                    onChanged: (val) {
                      setState(() => _personalno = val);
                    }),
                SizedBox(height: 10),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Mobile No.',
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 1.0),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 3.0),
                            borderRadius: BorderRadius.circular(10))),
                    validator: (val) =>
                        val.isEmpty ? 'Enter your Personal No.' : null,
                    onChanged: (val) {
                      setState(() => _mobileno = val);
                    }),
                SizedBox(height: 10),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Number of People',
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 1.0),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrange, width: 3.0),
                            borderRadius: BorderRadius.circular(10))),
                    validator: (val) => int.tryParse(val) > 200
                        ? 'Number of Peoples should be less than 200'
                        : null,
                    onChanged: (val) {
                      setState(() => numberOfPeople = int.tryParse(val));
                    }),
                const SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(10),
                  child: DropdownButton(
                      value: _value1,
                      items: [
                        DropdownMenuItem(
                          child: Text("Yellow"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("Red"),
                          value: 2,
                        ),
                        DropdownMenuItem(child: Text("Blue"), value: 3),
                        DropdownMenuItem(child: Text("Milan"), value: 4),
                        DropdownMenuItem(child: Text("Milap Hall"), value: 5),
                        DropdownMenuItem(child: Text("Main Banquet"), value: 6),
                        DropdownMenuItem(
                            child: Text("Wedding Banquet"), value: 7),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _value1 = value;
                        });
                      }),
                ),
                const SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(10),
                  child: DropdownButton(
                      value: _value2,
                      items: [
                        DropdownMenuItem(
                          child: Text("Lunch Slot(12PM - 3PM)"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("Dinner Slot(7:30PM - 10.30PM)"),
                          value: 2,
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _value2 = value;
                          slot = value;
                        });
                      }),
                ),
                const SizedBox(height: 10.0),
                ListTile(
                  title: Text("Date (YYYY-MM-DD)"),
                  subtitle: Text(
                      "${_eventDate.year} - ${_eventDate.month} - ${_eventDate.day}"),
                  onTap: () async {
                    DateTime picked = await showDatePicker(
                        context: context,
                        initialDate: _eventDate,
                        firstDate: DateTime(_eventDate.year - 5),
                        lastDate: DateTime(_eventDate.year + 5));
                    if (picked != null) {
                      setState(() {
                        _eventDate = picked;
                      });
                    }
                  },
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                    color: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    child: Text(
                      'Book Now',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 25),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        confirmBooking();
                      }
                    }),
              ],
            ),
          ),
        ),
      );
    }
  }
}

// class AddEventPage extends StatefulWidget {
//   final EventModel note;

//   const AddEventPage({Key key, this.note}) : super(key: key);

//   @override
//   _AddEventPageState createState() => _AddEventPageState();
// }

// class _AddEventPageState extends State<AddEventPage> {
//   GoogleFonts.inter style = GoogleFonts.inter(fontFamily: 'Montserrat', fontSize: 20.0);
//   TextEditingController _name;
//   TextEditingController _personalno;
//   TextEditingController _Lounge;
//   DateTime _eventDate;
//   final _formKey = GlobalKey<FormState>();
//   final _key = GlobalKey<ScaffoldState>();
//   bool processing;

//   @override
//   void initState() {
//     super.initState();
//     _name = TextEditingController(text: widget.note != null ? widget.note.name : "");
//     _personalno = TextEditingController(text:  widget.note != null ? widget.note.personalno : "");
//     _Lounge = TextEditingController(text: widget.note != null ? widget.note.Lounge : "");
//     _eventDate = DateTime.now();
//     processing = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.note != null ? "Edit Note" : "Booking Details"),
//         elevation: 10.0,
//         backgroundColor: Colors.deepOrange,
//       ),
//       key: _key,
//       body: Form(
//         key: _formKey,
//         child: Container(
//           alignment: Alignment.center,
//           child: ListView(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                 child: TextFormField(
//                   controller: _name,
//                   validator: (value) =>
//                   (value.isEmpty) ? "Please Enter Your Name" : null,
//                   style: style,
//                   decoration: InputDecoration(
//                       labelText: "Name",
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                 child: TextFormField(
//                   controller: _personalno,
//                   //minLines: 3,
//                   //maxLines: 5,
//                   validator: (value) =>
//                   (value.isEmpty) ? "Please Enter Your Personal Number" : null,
//                   style: style,
//                   decoration: InputDecoration(
//                       labelText: "Personal No",
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
//                 ),
//               ),
//               const SizedBox(height: 10.0),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                 child: TextFormField(
//                   controller: _Lounge,
//                   validator: (value) =>
//                   (value.isEmpty) ? "Please Enter The Lounge you want to book (Yellow/Red/Blue) " : null,
//                   style: style,
//                   decoration: InputDecoration(
//                       labelText: "Lounge to book (Yellow/Red/Blue)",
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
//                 ),
//               ),
//               const SizedBox(height: 10.0),
//               ListTile(
//                 title: Text("Date (YYYY-MM-DD)"),
//                 subtitle: Text("${_eventDate.year} - ${_eventDate.month} - ${_eventDate.day}"),
//                 onTap: ()async{
//                   DateTime picked = await showDatePicker(context: context, initialDate: _eventDate, firstDate: DateTime(_eventDate.year-5), lastDate: DateTime(_eventDate.year+5));
//                   if(picked != null) {
//                     setState(() {
//                       _eventDate = picked;
//                     });
//                   }
//                 },
//               ),

//               SizedBox(height: 10.0),
//               processing
//                   ? Center(child: CircularProgressIndicator())
//                   : Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Material(
//                   elevation: 5.0,
//                   borderRadius: BorderRadius.circular(30.0),
//                   color: Theme.of(context).primaryColor,
//                   child: MaterialButton(
//                     onPressed: () async {
//                       if (_formKey.currentState.validate()) {
//                         setState(() {
//                           processing = true;
//                         });
//                         if(widget.note != null) {
//                           await eventDBS.updateData(widget.note.id,{
//                             "Name": _name.text,
//                             "personal no": _personalno.text,
//                             "Lounge": _Lounge.text,
//                             "event_date": widget.note.eventDate
//                           });
//                         }else{
//                           await eventDBS.createItem(EventModel(
//                               name: _name.text,
//                               personalno: _personalno.text,
//                               Lounge: _Lounge.text,
//                               eventDate: _eventDate
//                           ));
//                         }
//                         Navigator.pop(context);
//                         setState(() {
//                           processing = false;
//                         });
//                       }
//                     },
//                     child: Text(
//                       "Save",
//                       style: style.copyWith(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _name.dispose();
//     _personalno.dispose();
//     _Lounge.dispose();
//     super.dispose();
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rcapp/services/database.dart';

class AddressForm extends StatefulWidget {
  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final DatabaseService _formUploader = DatabaseService();
  final _formKey = GlobalKey<FormState>();

  // test field state
  String _houseno = '';
  String _streetname = '';
  String _area = '';
  String _city = '';
  String _pincode = '';
  String error = '';

  String _finaladdress = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text('Address Details'),
          elevation: 0.0,
          actions: <Widget>[
            /* FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Register'),
              onPressed: () {},
            ) */
          ]),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 18.0),
                    TextFormField(
                        decoration: InputDecoration(
                            hintText: 'House No.',
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
                        validator: (val) => val.isEmpty
                            ? 'Please Enter Your House Number'
                            : null,
                        onChanged: (val) {
                          setState(() => _houseno = val);
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Address Line 2',
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
                        /*validator: (val) => val.isEmpty
                            ? 'Please Enter Your Street Name'
                            : null,*/
                        obscureText: false,
                        onChanged: (val) {
                          setState(() => _streetname = val);
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: InputDecoration(
                            hintText: 'City',   //hardcode to rourkela
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
                            val.isEmpty ? 'Please Enter Your City' : null,
                        obscureText: false,
                        onChanged: (val) {
                          setState(() => _city = val);
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Pincode',
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
                            val.isEmpty ? 'Please Enter Your Pincode' : null,
                        obscureText: false,
                        onChanged: (val) {
                          setState(() => _pincode = val);
                        }),
                    SizedBox(height: 20.0),
                    Container(
                      width: 64.0,
                      height: 40,
                      child:RaisedButton(
                        color: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        child: Text(
                          'Save',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            var user =
                                (await FirebaseAuth.instance.currentUser()).uid;
                            setState(() {
                              _finaladdress = _houseno +
                                  ", " +
                                  _streetname +
                                  ", " +
                                  _city +
                                  "-" +
                                  _pincode;
                            });
                            print(_finaladdress);
                            dynamic result = await _formUploader
                                .updateAddressData(user, _finaladdress);
                            if (result != null) {
                              setState(() => error =
                              'could not upload address, please try again');
                            } else {
                              Navigator.popAndPushNamed(context, '/cart');
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      error,
                      style: GoogleFonts.inter(color: Colors.red, fontSize: 14.0),
                    )
                  ]),
            )),
      ),
    );
  }
}

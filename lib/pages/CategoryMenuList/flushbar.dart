import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showFlushbar(context) {
  Flushbar(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      borderRadius: 8,
      backgroundGradient: LinearGradient(
          colors: [Colors.deepOrange, Colors.deepOrange], stops: [0.6, 1]),
      boxShadows: [
        BoxShadow(color: Colors.black45, offset: Offset(3, 3), blurRadius: 3),
      ],
      duration: Duration(seconds: 5),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: "Item added to the cart",
      message: "Tap on the top cart icon to view your item in the cart and change quantity. Referesh to see the updated cart.")
    ..show(context);
}

void showFlushbarBooking(context) {
  Flushbar(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      borderRadius: 8,
      backgroundGradient: LinearGradient(
          colors: [Colors.deepOrange, Colors.deepOrange], stops: [0.6, 1]),
      boxShadows: [
        BoxShadow(color: Colors.black45, offset: Offset(3, 3), blurRadius: 3),
      ],
      duration: Duration(seconds: 5),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: "Room already booked for selected date",
      message: "Please select another date or different slot")
    ..show(context);
}

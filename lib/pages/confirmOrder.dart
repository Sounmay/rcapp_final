import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rcapp/pages/storeData.dart';
import 'package:rcapp/services/database.dart';
import 'package:flutter/material.dart';

StoreData storeData = StoreData();
  int total = 0;
  int totalquantity = 1;
  List<String> itemList = List<String>();
  List<int> quantityList = List<int>();

  void updateTotal() {
    Map<String, int> foodDetail = storeData.retrieveFoodDetails();
    Map<String, int> foodqtyDetail = storeData.retrieveQtyDetails();


      foodDetail.forEach((k, v) => total = total + v * foodqtyDetail[k]);
      foodDetail.forEach((k, v) => totalquantity = totalquantity + v);
      foodDetail.forEach((key, value) => itemList.add(key));
      foodqtyDetail.forEach((key, value) => quantityList.add(value));
  }

  void confirmOrder() async {
    var user = await FirebaseAuth.instance.currentUser();
    var _dat = await Firestore.instance
        .collection('userInfo')
        .document(user.uid)
        .get();

    var userName = _dat.data["name"];
    var number = _dat.data["number"];
    var address = _dat.data["address"];

    DatabaseService().confirmOrderofUser(user.uid, userName, number, address,
        itemList, quantityList, total, false);

    storeData.resetStore();
    updateTotal();
    // Navigator.pushReplacementNamed(context, '/navigationbar');
  }


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:rcapp/pages/Cart.dart';
// import 'package:rcapp/pages/order_cart.dart';
// import 'package:rcapp/pages/storeData.dart';
// import 'package:rcapp/services/database.dart';

// class ConfirmOrder extends StatefulWidget {
//   @override
//   _ConfirmOrderState createState() => _ConfirmOrderState();
// }

// class _ConfirmOrderState extends State<ConfirmOrder> {
//   StoreData storeData = StoreData();
//   int total = 0;
//   int totalquantity = 1;
//   List<String> itemList = List<String>();
//   List<int> quantityList = List<int>();

//   void updateTotal() {
//     Map<String, int> foodDetail = storeData.retrieveFoodDetails();
//     Map<String, int> foodqtyDetail = storeData.retrieveQtyDetails();

//     setState(() {
//       foodDetail.forEach((k, v) => total = total + v * foodqtyDetail[k]);
//       foodDetail.forEach((k, v) => totalquantity = totalquantity + v);
//       foodDetail.forEach((key, value) => itemList.add(key));
//       foodqtyDetail.forEach((key, value) => quantityList.add(value));
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     updateTotal();
//   }

//   void confirmOrder() async {
//     var user = await FirebaseAuth.instance.currentUser();
//     var _dat = await Firestore.instance
//         .collection('userInfo')
//         .document(user.uid)
//         .get();

//     var userName = _dat.data["name"];
//     var number = _dat.data["number"];
//     var address = _dat.data["address"];

//     DatabaseService().confirmOrderofUser(user.uid, userName, number, address,
//         itemList, quantityList, total, false);

//     storeData.resetStore();
//     updateTotal();
//     Navigator.pushReplacementNamed(context, '/navigationbar');
//   }

//   @override
//   Widget build(BuildContext context) {
//     Map<String, int> _foodNamePrice = storeData.retrieveFoodDetails();
//     return Scaffold(
//         appBar: AppBar(
//           elevation: 10.0,
//           backgroundColor: Colors.deepOrange,
//           title: Text('Payment'),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             SizedBox(
//                 child: Row(
//               children: <Widget>[
//                 IconButton(
//                   icon: Icon(Icons.radio_button_checked),
//                   color: Colors.green,
//                 ),
//                 Text('CASH ON DELIVERY')
//               ],
//             )),
//             // SizedBox(height: 300),
//             SizedBox(
//                 width: double.infinity,
//                 height: 60,
//                 child: ButtonTheme(
//                   child: RaisedButton(
//                       color: Colors.deepOrange,
//                       onPressed: () {
//                         confirmOrder();
//                       },
//                       child: Text('CONFIRM ORDER',
//                           style: TextStyle(color: Colors.white, fontSize: 18))),
//                 )),
//           ],
//         ));
//   }
// }

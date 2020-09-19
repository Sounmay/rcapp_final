import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rcapp/models/user.dart';

class AdminOrder extends StatefulWidget {
  @override
  _AdminOrderState createState() => _AdminOrderState();
}

class _AdminOrderState extends State<AdminOrder> {
  List<dynamic> orders = [];
  List<dynamic> item = [];
  List<dynamic> quantity = [];
  List<dynamic> total = [];

  void confirmOrder(int index, int date) async {
    // var docId = '${orders[index]["id"]}' + '${orders[index]["total"]}';
    await Firestore.instance
        .collection('confirmedOrders')
        .document('$date')
        .updateData({"isConfirmed": true});
    setState(() {
      orders[index]["isConfirmed"] = true;
    });
  }

  void deleteOrder(int index, int date) async {
    await Firestore.instance
        .collection('confirmedOrders')
        .document('$date')
        .delete();
    setState(() {
      orders.removeAt(index);
    });
  }

  void initialData() async {
    var result = await Firestore.instance
        .collection('confirmedOrders')
        .orderBy('_date', descending: true)
        .getDocuments();
    result.documents.forEach((res) {
      setState(() {
        orders.add(res.data);
        item.add(res.data["item"]);
        quantity.add(res.data["quantity"]);
        total.add(res.data["total"]);
      });
    });
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
    if (orders.length == 0 && item.length == 0 && quantity.length == 0) {
      return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              SpinKitCircle(color: Colors.deepOrange, size: 65),
              Text('Loading data')
            ])),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
          backgroundColor: Colors.deepOrange,
        ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(color: Colors.grey[200]),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: orders.length,
            itemBuilder: (_, index) {
              orderNo = 110;
              orderNo = orderNo + index;
              return ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 190.0,
                      width: 370.0,
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
                                "Order No: $orderNo",
                                style: GoogleFonts.inter(
                                    color: Colors.deepOrange, fontSize: 22),
                              ),
                              Flexible(child: Text('${orders[index]["date"]}')),
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
                                      "Name : " + "${orders[index]["name"]}",
                                      style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Personal No : " +
                                          "${orders[index]["number"]}",
                                      style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                if (orders[index]["isConfirmed"]) ...[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Status: Confirmed",
                                        style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ] else ...[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Status: Not Confirmed",
                                        style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ]
                              ]),
                          SizedBox(height: 15),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Cost : ₹" + "${orders[index]["total"]} ",
                                  style: GoogleFonts.inter(
                                      color: Colors.black, fontSize: 22),
                                ),
                                Row(children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminOrderDetails(
                                                      total: orders[index]
                                                          ["total"],
                                                      orderNo: orderNo,
                                                      name: orders[index]
                                                          ["name"],
                                                      date: orders[index]
                                                          ["date"],
                                                      number: orders[index]
                                                          ["number"],
                                                      address: orders[index]
                                                          ["address"],
                                                      item: item[index],
                                                      quantity:
                                                          quantity[index])));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 4),
                                      decoration: BoxDecoration(
                                          color: Colors.red[700],
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text('View',
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  if (!orders[index]["isConfirmed"]) ...[
                                    InkWell(
                                      onTap: () {
                                        confirmOrder(
                                            index, orders[index]["_date"]);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 4),
                                        decoration: BoxDecoration(
                                            color: Colors.deepOrange,
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text('Confirm',
                                            style: GoogleFonts.inter(
                                              color: Colors.white,
                                            )),
                                      ),
                                    )
                                  ] else ...[
                                    InkWell(
                                      onTap: () {
                                        deleteOrder(
                                            index, orders[index]["_date"]);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 4),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text('Delete',
                                            style: GoogleFonts.inter(
                                              color: Colors.white,
                                            )),
                                      ),
                                    )
                                  ]
                                ])
                              ]),
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

class AdminOrderData extends StatefulWidget {
  List item;
  List quantity;
  AdminOrderData({this.item, this.quantity});
  @override
  _AdminOrderDataState createState() => _AdminOrderDataState();
}

class _AdminOrderDataState extends State<AdminOrderData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
      height: 390,
      child: ListView.builder(
          itemCount: widget.item.length,
          itemBuilder: (_, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(children: <Widget>[
                  Text('${index + 1}) '),
                  Text('${widget.item[index]} '),
                ])),
                Text('${widget.quantity[index]}'),
              ],
            );
          }),
    );
  }
}

class AdminOrderDetails extends StatefulWidget {
  final int orderNo;
  final int total;
  final String address;
  final String name;
  final String number;
  final String date;
  final List item;
  final List quantity;
  AdminOrderDetails({
    this.orderNo,
    this.total,
    this.address,
    this.name,
    this.number,
    this.date,
    this.item,
    this.quantity,
  });
  @override
  _AdminOrderDetailsState createState() => _AdminOrderDetailsState();
}

class _AdminOrderDetailsState extends State<AdminOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text('Details'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 0),
          decoration: BoxDecoration(color: Colors.grey[300]),
          child: ListTile(
            contentPadding: EdgeInsets.all(10),
            title: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 500.0,
                    width: 370.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "#${widget.orderNo}",
                              style: GoogleFonts.inter(
                                  color: Colors.deepOrange, fontSize: 22),
                            ),
                            Flexible(child: Text('${widget.date}')),
                          ],
                        ),
                        SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "${widget.name}",
                                  style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Personal No. :",
                                  style: GoogleFonts.inter(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 5),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text(
                                    "${widget.number}",
                                    style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Delivered To : ",
                                        style: GoogleFonts.inter(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                        width: 300,
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          child: Text(
                                            "${widget.address}",
                                            style: GoogleFonts.inter(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      )
                                    ]),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Menu :',
                              style: GoogleFonts.inter(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            )),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Item Name',
                                  style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline)),
                              Text('Quantity',
                                  style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline))
                            ],
                          ),
                        ),
                        Flexible(
                          child: AdminOrderData(
                              item: widget.item, quantity: widget.quantity),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Cost : ",
                                style: GoogleFonts.inter(
                                    color: Colors.black, fontSize: 22),
                              ),
                              Text(
                                "₹${widget.total} ",
                                style: GoogleFonts.inter(
                                    color: Colors.black, fontSize: 22),
                              ),
                            ]),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

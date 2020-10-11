import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rcapp/pages/Food.dart';
import 'package:rcapp/pages/customAlert.dart';
import 'package:rcapp/pages/order_cart.dart';
import 'package:rcapp/pages/storeData.dart';
import 'package:rcapp/services/database.dart';
import './confirmOrder.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  // StoreData storeData = StoreData();
  int total = 0;
  int totalquantity = 1;

  StoreData storeDataforCart = StoreData();

  var address = '';
  bool isData = false;
  bool loading = true;

  void init() async {
    var user = await FirebaseAuth.instance.currentUser();
    var _dat = await Firestore.instance
        .collection('userInfo')
        .document(user.uid)
        .get();

    setState(() {
      address = _dat.data["address"];
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    updateTotal();
  }

  List<int> qtyList = List<int>();

  void updateTotal() {
    Map<String, int> foodDetail = storeDataforCart.retrieveFoodDetails();
    Map<String, int> qtyDetail = storeDataforCart.retrieveQtyDetails();

    total = 0;
    totalquantity = 0;

    setState(() {
      qtyDetail.forEach((key, value) {
        totalquantity += value;
        qtyList.add(value);
      });
      foodDetail.forEach((k, v) => total = total + v * qtyDetail[k]);
      if (totalquantity == 0) {
        isData = false;
      } else {
        isData = true;
      }
    });
  }

  void removeItem(String item) {
    storeDataforCart.removeFoodDetails(item);
    updateTotal();
    print(item);
  }

  void quantityIncreement(String foodName) {
    storeDataforCart.increaseQty(foodName);
    updateTotal();
  }

  void quantityDecreement(String foodName) {
    storeDataforCart.decreaseQty(foodName);
    updateTotal();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> _foodNamePrice = storeDataforCart.retrieveFoodDetails();
    Map<String, int> _foodQtyPrice = storeDataforCart.retrieveQtyDetails();
    updateTotal();
    return Scaffold(
        appBar: AppBar(
          elevation: 10.0,
          backgroundColor: Colors.deepOrange,
          title: Text('Cart',
              style: GoogleFonts.inter()), //repeat for menu and booking
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                refreshVar = !refreshVar;
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            );
          }),
        ),
        body: Column(children: <Widget>[
          SizedBox(height: 10),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'Deliver To:',
                      style: GoogleFonts.inter(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(children: <Widget>[
                    Container(
                      child: Text(
                        'Change/Add',
                        style: GoogleFonts.inter(
                            decoration: TextDecoration.underline,
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.deepOrange,
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/address');
                        },
                      ),
                    )
                  ])
                ],
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Text(
                    '$address',
                    style: GoogleFonts.inter(fontSize: 16),
                  ))
            ],
          ),
          SizedBox(height: 20),
          OrderCard(total: total),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _foodNamePrice.keys.length,
                itemBuilder: (BuildContext context, index) {
                  String keyname = _foodNamePrice.keys.elementAt(index);
                  int price = _foodNamePrice[keyname];
                  int qty = _foodQtyPrice[keyname];
                  return ListTile(
                    // onTap: () {
                    //   removeItem(keyname);
                    // },
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    print(keyname);
                                  },
                                  icon: Icon(
                                    Icons.check_box,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.52,
                                  child: Text(
                                    keyname,
                                    style: GoogleFonts.inter(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                            QuantityInCart(
                                index: index,
                                price: price,
                                qtyList: qtyList,
                                qty: qty,
                                keyname: keyname,
                                quantityDecreement: quantityDecreement,
                                quantityIncreement: quantityIncreement,
                                removeItem: removeItem)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin:
                                  new EdgeInsets.symmetric(horizontal: 50.0),
                              child: Text(
                                '₹' + '$price' + '   Quantity: ' + '$qty',
                                style: GoogleFonts.inter(
                                    fontSize: 15, fontWeight: FontWeight.bold),
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
                    ),
                  );
                }),
          ),
          ProceedAccess(address: address, isData: isData, loading: loading)
        ]));
  }
}

class QuantityInCart extends StatefulWidget {
  int index;
  int price;
  int qty;
  List<int> qtyList;
  String keyname;
  final quantityIncreement;
  final quantityDecreement;
  final removeItem;

  QuantityInCart(
      {this.index,
      this.price,
      this.qtyList,
      this.qty,
      this.keyname,
      this.quantityDecreement,
      this.quantityIncreement,
      this.removeItem});
  @override
  _QuantityInCartState createState() => _QuantityInCartState();
}

class _QuantityInCartState extends State<QuantityInCart> {
  @override
  Widget build(BuildContext context) {
    if (widget.qtyList[widget.index] == 0) {
      return InkWell(
        onTap: () {
          print(widget.keyname);
          widget.quantityIncreement(widget.keyname);
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 14, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey, width: 0.1),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey, blurRadius: 2.0, offset: Offset(2.1, 2.2))
            ],
          ),
          height: 25,
          width: 62,
          child: Center(
              child: Text('Add',
                  style: GoogleFonts.inter(color: Colors.deepOrange))),
        ),
      );
    } else {
      return Row(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey, width: 0.1),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    offset: Offset(2.1, 2.2))
              ],
            ),
            height: 25,
            width: 30,
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.remove,
                size: 18,
                color: Colors.white,
              ),
              onPressed: () {
                if (widget.qtyList[widget.index] > 0) {
                  print(widget.key);
                  widget.quantityDecreement(widget.keyname);
                  if (widget.qty == 1) {
                    widget.removeItem(widget.keyname);
                  }
                }
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey, width: 0.1),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    offset: Offset(2.1, 2.2))
              ],
            ),
            height: 28,
            width: 33,
            child: Text(
              '${widget.qty}',
              style:
                  GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          // Text(
          //   '$FQty',
          //   style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold),
          // ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey, width: 0.1),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    offset: Offset(2.1, 2.2))
              ],
            ),
            height: 25,
            width: 30,
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.add,
                size: 18,
                color: Colors.white,
              ),
              onPressed: () {
                print(widget.index);
                if (widget.qtyList[widget.index] > 0) {
                  print(widget.keyname);
                  widget.quantityIncreement(widget.keyname);
                }
              },
            ),
          ),
        ],
      );
    }
  }
}

class ProceedAccess extends StatefulWidget {
  var isData;
  var loading;
  var address;
  ProceedAccess({this.address, this.isData, this.loading});
  @override
  _ProceedAccessState createState() => _ProceedAccessState();
}

class _ProceedAccessState extends State<ProceedAccess> {
  StoreData storeData = StoreData();
  int total = 0;
  int totalquantity = 1;
  List<String> itemList = List<String>();
  List<int> priceList = List<int>();
  List<int> quantityList = List<int>();

  void updateTotal() {
    Map<String, int> foodDetail = storeData.retrieveFoodDetails();
    Map<String, int> foodqtyDetail = storeData.retrieveQtyDetails();

    setState(() {
      foodDetail.forEach((k, v) => total = total + v * foodqtyDetail[k]);
      foodDetail.forEach((k, v) => totalquantity = totalquantity + v);
      foodDetail.forEach((key, value) {
        itemList.add(key);
        priceList.add(value);
      });
      foodqtyDetail.forEach((key, value) => quantityList.add(value));
    });
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
    var mobileNumber = _dat.data["mobileNumber"];

    DatabaseService().confirmOrderofUser(user.uid, userName, number, address,
        itemList, priceList, quantityList, total, false, mobileNumber);

    storeData.resetStore();
    updateTotal();
    /*Navigator.pushReplacementNamed(context, '/navigationbar');*/
  }

  @override
  Widget build(BuildContext context) {
    if (widget.loading == true) {
      return Container(
          width: double.infinity,
          height: 50,
          child: FlatButton(
              color: Colors.deepOrange,
              onPressed: () {
                Navigator.pushNamed(context, '/address');
              },
              child: Text(
                'Please Wait ...',
                style: GoogleFonts.inter(color: Colors.white),
              )));
    } else if (widget.address == '' && widget.loading == false) {
      return Container(
          width: double.infinity,
          height: 50,
          child: FlatButton(
              color: Colors.deepOrange,
              onPressed: () {
                Navigator.pushNamed(context, '/address');
              },
              child: Text(
                'Add address to proceed',
                style: GoogleFonts.inter(color: Colors.white),
              )));
    } else if (widget.address != '' && widget.isData == true) {
      return Container(
          width: double.infinity,
          height: 50,
          child: FlatButton(
              color: Colors.deepOrange,
              onPressed: () {
                updateTotal();
                confirmOrder();
                showDialog(
                    context: context,
                    builder: (context) => CustomAlert(
                          title: 'Order Placed!',
                          description:
                              'Your Order has been placed and will be on its way to you shortly. For further queries regarding your order, please contact - Mr. Debabrata Mohanty - +919438208969',
                          // url: 'assets/nigga.gif',
                        ));
                // Navigator.pop(context);
              },
              child: Text(
                'Confirm Order(Pay through COD)',
                style: GoogleFonts.inter(color: Colors.white),
              )));
    } else if (widget.isData == false) {
      return Container(
          width: double.infinity,
          height: 50,
          child: FlatButton(
              color: Colors.deepOrange,
              onPressed: () {},
              child: Text(
                'Add Item To Cart',
                style: GoogleFonts.inter(color: Colors.white),
              )));
    }
  }
}

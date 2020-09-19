import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rcapp/pages/Food.dart';
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

  void init() async {
    var user = await FirebaseAuth.instance.currentUser();
    var _dat = await Firestore.instance
        .collection('userInfo')
        .document(user.uid)
        .get();

    setState(() {
      address = _dat.data["address"];
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
    });
  }

  void removeItem(String item) {
    // if ((cartList.singleWhere((element) => element.item == item,
    //         orElse: () => null)) !=
    //     null) {
    //   return;
    // } else {
    //   cartList.add(Orders(item, price, 1));
    // }
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
          title: Text('Cart'),
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
                                  width: 200,
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
          // BottomItemView(total: total, qty: totalquantity),
          ProceedAccess(address: address)
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
              child: Text('Add', style: GoogleFonts.inter(color: Colors.deepOrange))),
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
              style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold),
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
  var address;
  ProceedAccess({this.address});
  @override
  _ProceedAccessState createState() => _ProceedAccessState();
}

class _ProceedAccessState extends State<ProceedAccess> {
  @override
  Widget build(BuildContext context) {
    if (widget.address == '') {
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
    } else if (widget.address != '') {
      return Container(
          width: double.infinity,
          height: 50,
          child: FlatButton(
              color: Colors.deepOrange,
              onPressed: () {
                updateTotal();
                confirmOrder();
                Navigator.pushReplacementNamed(context, '/navigationbar');
              },
              child: Text(
                'Proceed to Pay',
                style: GoogleFonts.inter(color: Colors.white),
              )));
    } else if (widget.address == null) {
      return Container(
          width: double.infinity, height: 50, child: SpinKitChasingDots());
    }
  }
}

// class BottomItemView extends StatefulWidget {
//   @override
//   _BottomItemViewState createState() => _BottomItemViewState();
// }

class BottomItemView extends StatelessWidget {
  int total;
  int qty;
  BottomItemView({this.total, this.qty});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 54,
      decoration: BoxDecoration(color: Colors.deepOrange),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '${qty} ' + '  item ' + '|' + ' ' + '₹ ' + '${total}',
              style:
                  GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: (() => Navigator.pushNamed(context, '/cart')),
              child: Text(
                'VIEW CART',
                style:
                    GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

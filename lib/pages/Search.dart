import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rcapp/pages/CategoryMenuList/flushbar.dart';
import 'package:rcapp/pages/searchService.dart';
import 'package:rcapp/pages/storeData.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var queryResultSet = [];
  var tempSearchStore = [];
  var priceStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
      print(tempSearchStore);
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['item'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 4),
        child: TextField(
          onChanged: (val) {
            initiateSearch(val);
          },
          decoration: InputDecoration(
              prefixIcon: IconButton(
                color: Colors.black,
                icon: Icon(Icons.search),
                iconSize: 20.0,
                onPressed: () {},
              ),
              contentPadding: EdgeInsets.only(left: 25.0),
              hintText: 'Search by item name',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))),
        ),
      ),
      SearchList(tempSearchStore: tempSearchStore),
    ]);
  }
}

class SearchQuantity extends StatefulWidget {
  final item;
  final price;
  SearchQuantity({this.item, this.price});
  @override
  _SearchQuantityState createState() => _SearchQuantityState();
}

class _SearchQuantityState extends State<SearchQuantity> {
  int FQty = 0;

  StoreData storeData = StoreData();

  void addToCart(String item, int price) {
    // String item = post.item;
    // int price = post.price;

    Map<String, int> qtyDetail = storeData.retrieveQtyDetails();

    int qty = 1;

    qtyDetail.forEach((key, value) {
      if (key == item) {
        qty = value;
      }
    });

    if (qty > 1) {
      storeData.StoreFoodDetails(item, price, qty);
    } else {
      storeData.StoreFoodDetails(item, price, 1);
    }
    showFlushbar(context);
  }

  @override
  Widget build(BuildContext context) {
    if (FQty == 0) {
      return InkWell(
        onTap: () {
          addToCart(widget.item, widget.price);
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 14, 0),
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey, width: 0.1),
          ),
          height: 25,
          width: 62,
          child:
              Center(child: Text('Add', style: GoogleFonts.inter(color: Colors.white))),
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
              // boxShadow: [
              //   BoxShadow(
              //       color: Colors.grey,
              //       blurRadius: 2.0,
              //       offset: Offset(2.1, 2.2))
              // ],
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
                setState(() {
                  if (FQty > 0) {
                    FQty -= 1;
                  }
                });
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
              '$FQty',
              style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
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
                setState(() {
                  if (FQty > 0) {
                    FQty += 1;
                  }
                });
              },
            ),
          ),
        ],
      );
    }
  }
}

class SearchList extends StatefulWidget {
  var tempSearchStore;
  SearchList({this.tempSearchStore});
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border(
            left: BorderSide(color: Colors.grey[400]),
            right: BorderSide(color: Colors.grey[400]),
            bottom: BorderSide(color: Colors.grey[300]),
          )),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.tempSearchStore.length,
          itemBuilder: (context, index) {
            return Container(
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              padding: EdgeInsets.fromLTRB(10, 7, 5, 5),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 0.5,
                      offset: Offset(1.1, 1.2))
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${widget.tempSearchStore[index]['item']}',
                    style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SearchQuantity(
                      item: widget.tempSearchStore[index]['item'],
                      price: widget.tempSearchStore[index]['price']),
                ],
              ),
            );
          }),
    );
  }
}

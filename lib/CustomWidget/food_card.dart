import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rcapp/models/user.dart';
import 'package:rcapp/pages/CategoryMenuList/flushbar.dart';
import 'package:rcapp/pages/storeData.dart';

class FoodCard extends StatelessWidget {
  final String categoryName;
  final String imagePath;
  final int itemprice;
  final bool areYouAdmin;

  FoodCard(
      {this.areYouAdmin, this.categoryName, this.imagePath, this.itemprice});

  StoreData storeData = StoreData();

  void deleteMenu() {
    var menu = Firestore.instance
        .collection('Today_Menu_Data')
        .where('category_menu', isEqualTo: categoryName);
    menu.getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((element) {
        element.reference.delete();
      });
    });
  }

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
  }

  @override
  Widget build(BuildContext context) {
    return areYouAdmin
        ? FocusedMenuHolder(
            onPressed: () {},
            menuItems: <FocusedMenuItem>[
              FocusedMenuItem(
                  title: Text('Delete the item'),
                  onPressed: () {
                    deleteMenu();
                  })
            ],
            child: Container(
                width: MediaQuery.of(context).size.width * 0.41,
                margin: EdgeInsets.only(right: 10.0),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(6)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              deleteMenu();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Icon(
                                Icons.delete_outline,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                  child: Text(
                                    categoryName,
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0,
                                        color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                    child: Text(
                                      '₹' + '$itemprice',
                                      style: GoogleFonts.inter(
                                          color: Colors.white),
                                    ))
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                addToCart(categoryName, itemprice);
                                showFlushbar(context);
                              },
                              child: Container(
                                height: 25,
                                width: MediaQuery.of(context).size.width * 0.1,
                                decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    border: Border.all(
                                        color: Colors.black, width: 0.1),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    'Add',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ])
                    ],
                  ),
                )),
          )
        : Container(
            width: MediaQuery.of(context).size.width * 0.41,
            margin: EdgeInsets.only(right: 10.0),
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imagePath),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(6)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.03,
                              child: Text(
                                categoryName,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0,
                                    color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.03,
                              child: Text(
                                '₹' + '$itemprice',
                                style: GoogleFonts.inter(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            addToCart(categoryName, itemprice);
                            showFlushbar(context);
                          },
                          child: Container(
                            height: 25,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                border:
                                    Border.all(color: Colors.black, width: 0.1),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                'Add',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ])
                ],
              ),
            ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rcapp/models/user.dart';
import 'package:rcapp/pages/storeData.dart';
import 'food_card.dart';
import 'package:provider/provider.dart';
import 'package:rcapp/services/database.dart';

// DAta
import '../data/category_data.dart';

// Model
import '../models/category_model.dart';

// class FoodCategory extends StatefulWidget {
//   @override
//   _FoodCategoryState createState() => _FoodCategoryState();
// }

class FoodCategory extends StatelessWidget {
  // final List<Category> _categories = categories;
  final bool areYouAdmin;

  FoodCategory(this.areYouAdmin);

  @override
  Widget build(BuildContext context) {
    final _menuList = Provider.of<List<Today_Menu>>(context) ?? [];
    if (_menuList.length == 0) {
      return Container(
        height: 90,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitCircle(
                color: Colors.deepOrange,
                size: 45,
              ),
              SizedBox(height: 20),
              Text('LOADING',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w400))
            ]),
      );
    } else {
      return Container(
        height: 105.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _menuList.length,
          itemBuilder: (BuildContext context, int index) {
            return FoodCard(
              areYouAdmin: areYouAdmin,
              categoryName: _menuList[index].category_menu,
              imagePath: _menuList[index].imagepath,
              itemprice: _menuList[index].price,
            );
          },
        ),
      );
    }
  }
}

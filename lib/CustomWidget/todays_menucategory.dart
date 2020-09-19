import 'package:flutter/material.dart';
import 'package:rcapp/CustomWidget/todays_menucard.dart';
import 'package:rcapp/data/todays_menu.dart';
import 'package:rcapp/models/todays_menumodel.dart';

class TodaysMenuCategory extends StatelessWidget {
  final List<TodaysMenu> _categories = todaymenucategories;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (BuildContext context, int index) {
          return TodayFoodCard(
            categoryName: _categories[index].categoryName,
            imagePath: _categories[index].imagePath,
            itemprice: _categories[index].itemprice,
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rcapp/CustomWidget/menu_card.dart';
import 'package:rcapp/data/food_category.dart';
import 'package:rcapp/models/menucategory_model.dart';


class MenuCategories extends StatelessWidget {
  final List<MenuCategory> _categories = menucategories;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (BuildContext context, int index) {
          return MenuCard(
            categoryName: _categories[index].categoryName,
            imagePath: _categories[index].imagePath,
            index: index,
          );
        },
      ),
    );
  }
}

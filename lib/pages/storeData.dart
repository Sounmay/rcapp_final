import 'package:flutter/material.dart';

class StoreData with ChangeNotifier {
  StoreData._privateConstructor();
  static final StoreData _instance = StoreData._privateConstructor();

  factory StoreData() {
    return _instance;
  }

  Map<String, int> _foodNamePrice = Map<String, int>();
  Map<String, int> _foodNameQuantity = Map<String, int>();

  void StoreFoodDetails(String foodName, int foodPrice, int value) {
    _foodNamePrice[foodName] = foodPrice;
    _foodNameQuantity[foodName] = value;
    notifyListeners();
  }

  void removeFoodDetails(String foodName) {
    _foodNamePrice.remove(foodName);
    _foodNameQuantity.remove(foodName);
    notifyListeners();
  }

  void increaseQty(String foodName) {
    ++_foodNameQuantity[foodName];
    notifyListeners();
  }

  void decreaseQty(String foodName) {
    if (_foodNameQuantity[foodName] != 0) {
      --_foodNameQuantity[foodName];
    }
    notifyListeners();
  }

  void resetStore() {
    _foodNamePrice.clear();
    _foodNameQuantity.clear();
    notifyListeners();
  }

  Map<String, int> retrieveFoodDetails() {
    return _foodNamePrice;
  }

  Map<String, int> retrieveQtyDetails() {
    return _foodNameQuantity;
  }
}

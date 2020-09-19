import 'package:flutter/material.dart';

class StoreData {
  StoreData._privateConstructor();
  static final StoreData _instance = StoreData._privateConstructor();

  factory StoreData() {
    return _instance;
  }

  Map<String, int> _foodNamePrice = Map<String, int>();
  Map<String, int> _foodNameQuantity = Map<String, int>();

  getInstance() {}

  void StoreFoodDetails(String foodName, int foodPrice, int value) {
    _foodNamePrice[foodName] = foodPrice;
    _foodNameQuantity[foodName] = value;
  }

  void removeFoodDetails(String foodName) {
    _foodNamePrice.remove(foodName);
    _foodNameQuantity.remove(foodName);
  }

  void increaseQty(String foodName) {
    ++_foodNameQuantity[foodName];
  }

  void decreaseQty(String foodName) {
    if (_foodNameQuantity[foodName] != 0) {
      --_foodNameQuantity[foodName];
    }
  }

  void resetStore() {
    _foodNamePrice.clear();
    _foodNameQuantity.clear();
  }

  Map<String, int> retrieveFoodDetails() {
    return _foodNamePrice;
  }

  Map<String, int> retrieveQtyDetails() {
    return _foodNameQuantity;
  }
}
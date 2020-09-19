class User {
  final String uid;

  User({this.uid});
}

class UserData {
  String uid;
  String name;
  String number;
  bool isAdmin;

  setvalues(String uid, String name, String number, bool isAdmin) {
    this.uid = uid;
    this.name = name;
    this.number = number;
    this.isAdmin = isAdmin;
  }
}

UserData currentUser;

class Menu {
  String item = '';
  int price = 0;
  String searchIndex = '';

  Menu({this.item, this.price, this.searchIndex});
}

class BreakfastMenu {
  String item = '';
  int price = 0;
  String searchIndex = '';

  BreakfastMenu({this.item, this.price, this.searchIndex});
}

class PaneerMenu {
  String item = '';
  int price = 0;
  String searchIndex = '';

  PaneerMenu({this.item, this.price, this.searchIndex});
}

class MainCourseMenu {
  String item = '';
  int price = 0;
  String searchIndex = '';

  MainCourseMenu({this.item, this.price, this.searchIndex});
}

class ChineseMenu {
  String item = '';
  int price = 0;
  String searchIndex = '';

  ChineseMenu({this.item, this.price, this.searchIndex});
}

class StarterMenu {
  String item = '';
  int price = 0;
  String searchIndex = '';

  StarterMenu({this.item, this.price, this.searchIndex});
}

class BiryaniMenu {
  String item = '';
  int price = 0;
  String searchIndex = '';

  BiryaniMenu({this.item, this.price, this.searchIndex});
}

class BreadMenu {
  String item = '';
  int price = 0;
  String searchIndex = '';

  BreadMenu({this.item, this.price, this.searchIndex});
}

class TandooriMenu {
  String item = '';
  int price = 0;
  String searchIndex = '';

  TandooriMenu({this.item, this.price, this.searchIndex});
}

class FriedRiceAndNoodlesMenu {
  String item = '';
  int price = 0;
  String searchIndex = '';

  FriedRiceAndNoodlesMenu({this.item, this.price, this.searchIndex});
}

class RollMenu {
  String item = '';
  int price = 0;
  String searchIndex = '';

  RollMenu({this.item, this.price, this.searchIndex});
}

class SandwichMenu {
  String item = '';
  int price = 0;
  String searchIndex = '';

  SandwichMenu({this.item, this.price, this.searchIndex});
}

class PizzaMenu {
  String item = '';
  int price = 0;
  String searchIndex = '';

  PizzaMenu({this.item, this.price, this.searchIndex});
}

class SnacksMenu {
  String item = '';
  int price = 0;
  String searchIndex = '';

  SnacksMenu({this.item, this.price, this.searchIndex});
}

class BurgerMenu {
  String item = '';
  int price = 0;
  String searchIndex = '';

  BurgerMenu({this.item, this.price, this.searchIndex});
}

class PastaMenu {
  String item = '';
  int price = 0;
  String searchIndex = '';

  PastaMenu({this.item, this.price, this.searchIndex});
}

class SoupMenu {
  String item = '';
  int price = 0;
  String searchIndex = '';

  SoupMenu({this.item, this.price, this.searchIndex});
}

class AccompanimentMenu {
  String item = '';
  int price = 0;
  String searchIndex = '';

  AccompanimentMenu({this.item, this.price, this.searchIndex});
}

class Today_Menu {
  String imagepath = '';
  int price = 0;
  String category_menu = '';

  Today_Menu({this.imagepath, this.price, this.category_menu});
}

class Orders {
  List item;
  List qty;
  String name;
  String number;
  String address;
  int total;
  bool isConfirmed;
  String date;

  Orders(
      {this.item,
      this.qty,
      this.name,
      this.number,
      this.address,
      this.total,
      this.isConfirmed,
      this.date});
}

class PreviousOrders {
  List item;
  List qty;
  String name;
  String number;
  String address;
  int total;
  bool isConfirmed;

  PreviousOrders(
      {this.item,
      this.qty,
      this.name,
      this.number,
      this.address,
      this.total,
      this.isConfirmed});
}

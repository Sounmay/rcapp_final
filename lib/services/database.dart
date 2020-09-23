import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rcapp/models/category.dart';
import 'package:rcapp/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference foodCollection =
      Firestore.instance.collection('food');

  //collection reference to different categories of food from firestore
  final CollectionReference allmenufoods =
      Firestore.instance.collection('All_Menu');
  final CollectionReference breakfastmenufoods =
      Firestore.instance.collection('Breakfast');
  final CollectionReference chinesefoods =
      Firestore.instance.collection('Chinese');
  final CollectionReference biryanifoods =
      Firestore.instance.collection('Biryani');
  final CollectionReference starterfoods =
      Firestore.instance.collection('Starter');
  final CollectionReference maincoursefoods =
      Firestore.instance.collection('MainCourse');
  final CollectionReference breadsfoods =
      Firestore.instance.collection('Breads');
  final CollectionReference tandoorifoods =
      Firestore.instance.collection('Tandoori');
  final CollectionReference friedriceandnoodlesfoods =
      Firestore.instance.collection('FriedRice_Noodles');
  final CollectionReference rollfoods = Firestore.instance.collection('Roll');
  final CollectionReference pizzafoods = Firestore.instance.collection('Pizza');
  final CollectionReference snacksfoods =
      Firestore.instance.collection('Snacks');
  final CollectionReference sandwichfoods =
      Firestore.instance.collection('Sandwich');
  final CollectionReference burgerfoods =
      Firestore.instance.collection('Burger');
  final CollectionReference pastafoods = Firestore.instance.collection('Pasta');
  final CollectionReference soupfoods = Firestore.instance.collection('Soup');
  final CollectionReference accompanimentfoods =
      Firestore.instance.collection('Accompaniments');
  final CollectionReference today_Menu_Data =
      Firestore.instance.collection('Today_Menu_Data');
  final CollectionReference notice_pdfData =
      Firestore.instance.collection('noticeBoard');

  final CollectionReference userInfo =
      Firestore.instance.collection('userInfo');

  final CollectionReference confirmedOrders =
      Firestore.instance.collection('confirmedOrders');

  final CollectionReference bookingDetails =
      Firestore.instance.collection('BookingDetails');

  Future updateUserInfo(
      String name, bool isAdmin, String number, var token) async {
    return await userInfo.document(uid).setData({
      'name': name,
      'isAdmin': isAdmin,
      'number': number,
      'address': '',
      'avatar': '',
      'token': token
    });
  }

  // Future updateToken(var token) async {
  //   return await userInfo.document(uid).updateData({'token': token});
  // }

  Future updateUserData(String food, int price, int quantity) async {
    return await foodCollection.document(uid).setData({
      'food': food,
      'price': price,
      'quantity': quantity,
    });
  }

  Future updateAddressData(String id, String address) async {
    return await userInfo.document(id).updateData({'address': address});
  }

  Future updateTodayMenu(String food, int price, String url) async {
    return await today_Menu_Data
        .document()
        .setData({'category_menu': food, 'itemprice': price, 'imagepath': url});
  }

  Future updateAvatar(String url, String uid) async {
    return await userInfo.document(uid).updateData({'avatar': url});
  }

  Future updatePdf(String title, String subtitle, String url) async {
    return await notice_pdfData
        .document()
        .setData({'title': title, 'subtitle': subtitle, 'downloadLink': url});
  }

  Future bookDetails(String id, String name, String number, int numberOfPeople,
      String lounge, int slot, DateTime date) async {
    var _date = DateTime.now().toUtc().millisecondsSinceEpoch;
    var forToken = await Firestore.instance.collection('userInfo').document(id).get();
    var _token = forToken.data["token"];
    return await bookingDetails.document('$_date').setData({
      '_date': _date,
      'id': id,
      'name': name,
      'isConfirmed': false,
      'number': number,
      'numberOfPeople': numberOfPeople,
      'lounge': lounge,
      'slot': slot,
      'date': '${date.day}' + '/' + '${date.month}' + '/' + '${date.year}',
      'bookingDate': date,
      'token': _token
    });
  }

  Future confirmOrderofUser(String id, String name, String number,
      String address, List item, List qty, int total, bool isConfirmed) async {
    // var docId = '$id' + '$total';
    var _date = DateTime.now().toUtc().millisecondsSinceEpoch;
    var forToken = await Firestore.instance.collection('userInfo').document(id).get();
    var _token = forToken.data["token"];
    return await confirmedOrders.document('$_date').setData({
      'id': id,
      'name': name,
      'number': number,
      'address': address,
      'item': item,
      'quantity': qty,
      'total': total,
      'isConfirmed': isConfirmed,
      '_date': _date,
      'date': '${DateTime.now().day}' +
          '/' +
          '${DateTime.now().month}' +
          '/' +
          '${DateTime.now().year}',
      'token': _token
    });
  }

  Future getPosts(numb) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('chinese').getDocuments();
    return qn.documents;
  }

  //Database related to categories of food data retrieval form firebase

  List<Menu> _menuListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Menu(
          item: doc.data["item"] ?? '',
          price: doc.data["price"] ?? 0,
          searchIndex: doc.data["search_index"] ?? '');
    }).toList();
  }

  List<MainCourseMenu> _maincoursemenuListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return MainCourseMenu(
          item: doc.data["item"] ?? '',
          price: doc.data["price"] ?? 0,
          searchIndex: doc.data["search_index"] ?? '');
    }).toList();
  }

  List<ChineseMenu> _chinesemenuListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ChineseMenu(
          item: doc.data["item"] ?? '',
          price: doc.data["price"] ?? 0,
          searchIndex: doc.data["search_index"] ?? '');
    }).toList();
  }

  List<StarterMenu> _startermenuListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return StarterMenu(
          item: doc.data["item"] ?? '',
          price: doc.data["price"] ?? 0,
          searchIndex: doc.data["search_index"] ?? '');
    }).toList();
  }

  List<BiryaniMenu> _biryanimenuListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return BiryaniMenu(
          item: doc.data["item"] ?? '',
          price: doc.data["price"] ?? 0,
          searchIndex: doc.data["search_index"] ?? '');
    }).toList();
  }

  // List<PaneerMenu> _paneermenuListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc) {
  //     return PaneerMenu(
  //         item: doc.data["item"] ?? '',
  //         price: doc.data["price"] ?? 0,
  //         searchIndex: doc.data["search_index"] ?? '');
  //   }).toList();
  // }

  List<BreadMenu> _breadmenuListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return BreadMenu(
          item: doc.data["item"] ?? '',
          price: doc.data["price"] ?? 0,
          searchIndex: doc.data["search_index"] ?? '');
    }).toList();
  }

  List<TandooriMenu> _tandoorimenuListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return TandooriMenu(
          item: doc.data["item"] ?? '',
          price: doc.data["price"] ?? 0,
          searchIndex: doc.data["search_index"] ?? '');
    }).toList();
  }

  List<FriedRiceAndNoodlesMenu> _firedriceandnoodlesmenuListFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return FriedRiceAndNoodlesMenu(
          item: doc.data["item"] ?? '',
          price: doc.data["price"] ?? 0,
          searchIndex: doc.data["search_index"] ?? '');
    }).toList();
  }

  List<RollMenu> _rollmenuListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return RollMenu(
          item: doc.data["item"] ?? '',
          price: doc.data["price"] ?? 0,
          searchIndex: doc.data["search_index"] ?? '');
    }).toList();
  }

  List<SandwichMenu> _sandwichmenuListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return SandwichMenu(
          item: doc.data["item"] ?? '',
          price: doc.data["price"] ?? 0,
          searchIndex: doc.data["search_index"] ?? '');
    }).toList();
  }

  List<PizzaMenu> _pizzamenuListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return PizzaMenu(
          item: doc.data["item"] ?? '',
          price: doc.data["price"] ?? 0,
          searchIndex: doc.data["search_index"] ?? '');
    }).toList();
  }

  List<SnacksMenu> _snackmenuListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return SnacksMenu(
          item: doc.data["item"] ?? '',
          price: doc.data["price"] ?? 0,
          searchIndex: doc.data["search_index"] ?? '');
    }).toList();
  }

  List<BurgerMenu> _burgermenuListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return BurgerMenu(
          item: doc.data["item"] ?? '',
          price: doc.data["price"] ?? 0,
          searchIndex: doc.data["search_index"] ?? '');
    }).toList();
  }

  List<PastaMenu> _pastamenuListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return PastaMenu(
          item: doc.data["item"] ?? '',
          price: doc.data["price"] ?? 0,
          searchIndex: doc.data["search_index"] ?? '');
    }).toList();
  }

  List<SoupMenu> _soupmenuListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return SoupMenu(
          item: doc.data["item"] ?? '',
          price: doc.data["price"] ?? 0,
          searchIndex: doc.data["search_index"] ?? '');
    }).toList();
  }

  List<AccompanimentMenu> _accompanimentmenuListFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return AccompanimentMenu(
          item: doc.data["item"] ?? '',
          price: doc.data["price"] ?? 0,
          searchIndex: doc.data["search_index"] ?? '');
    }).toList();
  }

  List<BreakfastMenu> _breakfastmenuListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return BreakfastMenu(
          item: doc.data["item"] ?? '',
          price: doc.data["price"] ?? 0,
          searchIndex: doc.data["search_index"] ?? '');
    }).toList();
  }

  List<Today_Menu> _todaymenuListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Today_Menu(
          imagepath: doc.data["imagepath"] ?? '',
          price: doc.data["itemprice"] ?? 0,
          category_menu: doc.data["category_menu"] ?? '');
    }).toList();
  }

  //Storing order data of customers as confirmedOrders in firesore_database

  List<Orders> _orderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Orders(
          item: doc.data["item"] ?? [],
          qty: doc.data["quantity"] ?? [],
          name: doc.data["name"] ?? '',
          number: doc.data["number"] ?? '',
          address: doc.data["address"] ?? '',
          total: doc.data["total"] ?? 0,
          isConfirmed: doc.data["isConfirmed"] ?? false);
    }).toList();
  }

  //Stream provider for different categories of food in widgets

  Stream<List<ChineseMenu>> get chinese {
    return chinesefoods.snapshots().map(_chinesemenuListFromSnapshot);
  }

  Stream<List<MainCourseMenu>> get maincourse {
    return maincoursefoods.snapshots().map(_maincoursemenuListFromSnapshot);
  }

  Stream<List<BiryaniMenu>> get biryani {
    return biryanifoods.snapshots().map(_biryanimenuListFromSnapshot);
  }

  Stream<List<StarterMenu>> get starter {
    return starterfoods.snapshots().map(_startermenuListFromSnapshot);
  }

  Stream<List<Menu>> get allmenu {
    return starterfoods.snapshots().map(_menuListFromSnapshot);
  }

  Stream<List<BreadMenu>> get breadmenu {
    return breadsfoods.snapshots().map(_breadmenuListFromSnapshot);
  }

  Stream<List<TandooriMenu>> get tandoorimenu {
    return tandoorifoods.snapshots().map(_tandoorimenuListFromSnapshot);
  }

  Stream<List<FriedRiceAndNoodlesMenu>> get friedriceandmenu {
    return friedriceandnoodlesfoods
        .snapshots()
        .map(_firedriceandnoodlesmenuListFromSnapshot);
  }

  Stream<List<RollMenu>> get rollmenu {
    return rollfoods.snapshots().map(_rollmenuListFromSnapshot);
  }

  Stream<List<SandwichMenu>> get sandwichmenu {
    return sandwichfoods.snapshots().map(_sandwichmenuListFromSnapshot);
  }

  Stream<List<PizzaMenu>> get pizzamenu {
    return pizzafoods.snapshots().map(_pizzamenuListFromSnapshot);
  }

  Stream<List<SnacksMenu>> get snackmenu {
    return snacksfoods.snapshots().map(_snackmenuListFromSnapshot);
  }

  Stream<List<BurgerMenu>> get burgermenu {
    return burgerfoods.snapshots().map(_burgermenuListFromSnapshot);
  }

  Stream<List<PastaMenu>> get pastamenu {
    return pastafoods.snapshots().map(_pastamenuListFromSnapshot);
  }

  Stream<List<SoupMenu>> get soupmenu {
    return soupfoods.snapshots().map(_soupmenuListFromSnapshot);
  }

  Stream<List<AccompanimentMenu>> get accompanimentmenu {
    return accompanimentfoods
        .snapshots()
        .map(_accompanimentmenuListFromSnapshot);
  }

  Stream<List<BreakfastMenu>> get breakfastmenu {
    return accompanimentfoods.snapshots().map(_breakfastmenuListFromSnapshot);
  }

  Stream<List<Today_Menu>> get today_Menu {
    return today_Menu_Data.snapshots().map(_todaymenuListFromSnapshot);
  }

  final CollectionReference menuorders =
      Firestore.instance.collection("confirmedOrders");

  Stream<List<Orders>> get orders {
    return menuorders.snapshots().map(_orderListFromSnapshot);
  }
}

// create menu object based on firebase
Future menu;

Future getPosts(numb) async {
  var firestore = Firestore.instance;
  QuerySnapshot qn =
      await firestore.collection('${menucategories[numb]}').getDocuments();
  return qn.documents;
}

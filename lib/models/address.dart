import 'package:firebase_helpers/firebase_helpers.dart';

class AddressModel extends DatabaseItem {
  final String id;
  final String houseno;
  final String streetname;
  final String area;
  final String city;
  final String pincode;

  AddressModel({this.id, this.houseno, this.streetname, this.area, this.city, this.pincode})
      : super(id);

  factory AddressModel.fromMap(Map data) {
    return AddressModel(
        houseno: data['houseno'],
        streetname: data['streetname'],
        area: data['area'],
        city: data['city'],
        pincode: data['pincode']
    );
  }

  factory AddressModel.fromDS(String id, Map<String, dynamic> data) {
    return AddressModel(
        id: id,
        houseno: data['houseno'],
        streetname: data['streetname'],
        area: data['area'],
        city: data['city'],
        pincode: data['pincode']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "houseno": houseno,
      "streetname": streetname,
      "area": area,
      "city": city,
      "pincode": pincode,
      "id": id,
    };
  }
}
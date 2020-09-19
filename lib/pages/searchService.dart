import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService{
  searchByName(String searchField){
    return Firestore.instance
        .collection('chinese')
        .where('search_index',
            isEqualTo: searchField.substring(0,1).toUpperCase())
        .getDocuments();
  }
}
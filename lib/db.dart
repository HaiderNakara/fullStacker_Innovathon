import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management_system/Screens/add_category/category.dart';
import 'package:inventory_management_system/Screens/add_product/add_product.dart';

class DatabaseService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addProduct(
    Map data,
  ) {
    return _db.collection("Products").doc(data["id"]).set(data);
  }

  Future<void> addCategory(Map data) {
    return _db.collection("category").doc(data['id']).set(data);
  }

  Stream<List<Category>> getCategoryStream() {
    var lol = _db.collection("category").snapshots().map((snaps) =>
        snaps.docs.map((e) => Category.fromFirestore(e.data())).toList());
    return lol;
  }
}

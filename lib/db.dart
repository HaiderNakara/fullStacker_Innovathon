import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management_system/Screens/add_category/category.dart';
import 'package:inventory_management_system/Screens/add_product/product.dart';

class DatabaseService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addProduct(
    Map data,
  ) {
    return _db.collection("Products").doc(data["id"]).set(data);
  }

  Future<void> editProduct(
    Map data,
    var id,
  ) {
    return _db.collection("Products").doc(id).update(data);
  }

  Future<void> deleteProduct(
    var id,
  ) {
    return _db.collection("Products").doc(id).delete();
  }

  Stream<List<Product>> getProductStream(var category) {
    var lol = _db
        .collection("Products")
        .where("category", isEqualTo: category)
        .snapshots()
        .map((snaps) =>
            snaps.docs.map((e) => Product.fromFirestore(e.data())).toList());
    return lol;
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

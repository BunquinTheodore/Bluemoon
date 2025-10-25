import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/models/product.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();
  final _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _productsCol => _db.collection('products');

  Stream<List<Product>> productsStream() {
    return _productsCol.orderBy('name').snapshots().map((s) => s.docs.map((d) => Product.fromMap({...d.data(), 'id': d.id})).toList());
  }

  Future<String> addProduct(Product p) async {
    final doc = await _productsCol.add(p.toMap()..remove('id'));
    return doc.id;
    }

  Future<void> updateProduct(Product p) async {
    await _productsCol.doc(p.id).update(p.toMap()..remove('id'));
  }

  Future<void> deleteProduct(String id) async {
    await _productsCol.doc(id).delete();
  }
}

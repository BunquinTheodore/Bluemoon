import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/services/firestore_service.dart';

class ProductsProvider extends ChangeNotifier {
  final _fs = FirestoreService.instance;
  List<Product> _products = [];
  StreamSubscription? _sub;
  bool _loading = false;
  String? _error;

  List<Product> get products => _products;
  bool get loading => _loading;
  String? get error => _error;

  void start() {
    _loading = true;
    _error = null;
    notifyListeners();
    _sub?.cancel();
    _sub = _fs.productsStream().listen((items) {
      _products = items;
      _loading = false;
      notifyListeners();
    }, onError: (e) {
      _error = e.toString();
      _loading = false;
      notifyListeners();
    });
  }

  Future<void> add(Product p) async {
    final id = await _fs.addProduct(p);
    // update local optimistic? stream will update shortly.
  }

  Future<void> update(Product p) async {
    await _fs.updateProduct(p);
  }

  Future<void> remove(String id) async {
    await _fs.deleteProduct(id);
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

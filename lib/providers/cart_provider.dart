 import 'package:flutter/foundation.dart';
 
 import '../config/constants.dart';
 import '../models/cart.dart';
 import '../models/product.dart';
 
 class CartProvider extends ChangeNotifier {
   final List<CartItem> _items = [];
 
   List<CartItem> get items => List.unmodifiable(_items);
 
   double get subtotal => _items.fold(0, (sum, i) => sum + i.totalPrice);
   double get deliveryFee => AppConstants.deliveryFee;
   double get total => subtotal + deliveryFee;
   int get count => _items.fold(0, (sum, i) => sum + i.quantity);
 
   void addItem({
     required Product product,
     required String size,
     required String sugarLevel,
     String? iceLevel,
     int quantity = 1,
   }) {
     // naive add: push new line item (no merge)
     _items.add(CartItem(
       product: product,
       size: size,
       sugarLevel: sugarLevel,
       iceLevel: iceLevel,
       quantity: quantity,
     ));
     notifyListeners();
   }
 
   void removeAt(int index) {
     if (index >= 0 && index < _items.length) {
       _items.removeAt(index);
       notifyListeners();
     }
   }
 
   void increment(int index) {
     if (index >= 0 && index < _items.length) {
       _items[index].quantity++;
       notifyListeners();
     }
   }
 
   void decrement(int index) {
     if (index >= 0 && index < _items.length) {
       if (_items[index].quantity > 1) {
         _items[index].quantity--;
         notifyListeners();
       }
     }
   }
 
   void clear() {
     _items.clear();
     notifyListeners();
   }
 }

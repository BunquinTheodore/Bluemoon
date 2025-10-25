 import 'package:flutter/foundation.dart';
 
 import '../models/cart.dart';
 import '../models/order.dart';
 
 class OrderProvider extends ChangeNotifier {
   final List<OrderModel> _orders = [];
 
   List<OrderModel> get orders => List.unmodifiable(_orders);
 
   OrderModel placeOrder({
     required List<CartItem> items,
     required double subtotal,
     required double deliveryFee,
   }) {
     final total = subtotal + deliveryFee;
     final order = OrderModel(
       id: DateTime.now().millisecondsSinceEpoch.toString(),
       items: items,
       subtotal: subtotal,
       deliveryFee: deliveryFee,
       total: total,
       status: 'pending',
       createdAt: DateTime.now(),
     );
     _orders.add(order);
     notifyListeners();
     return order;
   }
 }

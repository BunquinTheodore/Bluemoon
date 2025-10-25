 import 'cart.dart';
 
 class OrderModel {
   final String id;
   final List<CartItem> items;
   final double subtotal;
   final double deliveryFee;
   final double total;
   final String status; // use AppConstants.orderStatus*
   final DateTime createdAt;
   final String? userId;
 
   OrderModel({
     required this.id,
     required this.items,
     required this.subtotal,
     required this.deliveryFee,
     required this.total,
     required this.status,
     required this.createdAt,
     this.userId,
   });
 
   Map<String, dynamic> toMap() {
     return {
       'id': id,
       'items': items.map((e) => e.toMap()).toList(),
       'subtotal': subtotal,
       'deliveryFee': deliveryFee,
       'total': total,
       'status': status,
       'createdAt': createdAt.toIso8601String(),
       'userId': userId,
     };
   }
 
   factory OrderModel.fromMap(Map<String, dynamic> map) {
     return OrderModel(
       id: map['id'] ?? '',
       items: (map['items'] as List<dynamic>? ?? [])
           .map((e) => CartItem.fromMap(e as Map<String, dynamic>))
           .toList(),
       subtotal: (map['subtotal'] ?? 0).toDouble(),
       deliveryFee: (map['deliveryFee'] ?? 0).toDouble(),
       total: (map['total'] ?? 0).toDouble(),
       status: map['status'] ?? 'pending',
       createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
       userId: map['userId'],
     );
   }
 }

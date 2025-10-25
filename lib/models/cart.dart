import 'product.dart';

class CartItem {
  final Product product;
  final String size;
  final String sugarLevel;
  final String? iceLevel;
  int quantity;

  CartItem({
    required this.product,
    required this.size,
    required this.sugarLevel,
    this.iceLevel,
    this.quantity = 1,
  });

  double get totalPrice {
    // Calculate price based on size multiplier and quantity
    double basePrice = product.price;
    double sizeMultiplier = 1.0;
    
    switch (size) {
      case 'Small':
        sizeMultiplier = 1.0;
        break;
      case 'Medium':
        sizeMultiplier = 1.3;
        break;
      case 'Large':
        sizeMultiplier = 1.6;
        break;
    }
    
    return basePrice * sizeMultiplier * quantity;
  }

  // Convert to Map (for storing in database later)
  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'size': size,
      'sugarLevel': sugarLevel,
      'iceLevel': iceLevel,
      'quantity': quantity,
    };
  }

  // Create from Map
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: Product.fromMap(map['product']),
      size: map['size'] ?? 'Medium',
      sugarLevel: map['sugarLevel'] ?? '50%',
      iceLevel: map['iceLevel'],
      quantity: map['quantity'] ?? 1,
    );
  }
}
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final List<String> availableSizes;
  final bool isAvailable;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.availableSizes,
    this.isAvailable = true,
  });

  // Convert to Map (for Firebase later)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'availableSizes': availableSizes,
      'isAvailable': isAvailable,
    };
  }

  // Create from Map (from Firebase later)
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      imageUrl: map['imageUrl'] ?? '',
      category: map['category'] ?? '',
      availableSizes: List<String>.from(map['availableSizes'] ?? []),
      isAvailable: map['isAvailable'] ?? true,
    );
  }
}

// Dummy data for testing
class DummyData {
  static List<Product> products = [
    Product(
      id: '1',
      name: 'Caramel Macchiato',
      description: 'Rich espresso with vanilla syrup and caramel drizzle',
      price: 150.0,
      imageUrl: 'https://images.unsplash.com/photo-1570968915860-54d5c301fa9f?w=400',
      category: 'Hot Coffee',
      availableSizes: ['Small', 'Medium', 'Large'],
    ),
    Product(
      id: '2',
      name: 'Iced Americano',
      description: 'Bold espresso shots over ice',
      price: 120.0,
      imageUrl: 'https://images.unsplash.com/photo-1517487881594-2787fef5ebf7?w=400',
      category: 'Iced Coffee',
      availableSizes: ['Small', 'Medium', 'Large'],
    ),
    Product(
      id: '3',
      name: 'Cappuccino',
      description: 'Espresso with steamed milk foam',
      price: 140.0,
      imageUrl: 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=400',
      category: 'Hot Coffee',
      availableSizes: ['Small', 'Medium', 'Large'],
    ),
    Product(
      id: '4',
      name: 'Iced Mocha',
      description: 'Chocolate and espresso over ice',
      price: 160.0,
      imageUrl: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=400',
      category: 'Iced Coffee',
      availableSizes: ['Small', 'Medium', 'Large'],
    ),
    Product(
      id: '5',
      name: 'Matcha Latte',
      description: 'Premium Japanese matcha with milk',
      price: 145.0,
      imageUrl: 'https://images.unsplash.com/photo-1536013499025-4b01d0c0ca5e?w=400',
      category: 'Non-Coffee',
      availableSizes: ['Small', 'Medium', 'Large'],
    ),
    Product(
      id: '6',
      name: 'Spanish Latte',
      description: 'Sweet condensed milk with espresso',
      price: 155.0,
      imageUrl: 'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=400',
      category: 'Hot Coffee',
      availableSizes: ['Small', 'Medium', 'Large'],
    ),
  ];

  static List<String> categories = [
    'All',
    'Hot Coffee',
    'Iced Coffee',
    'Non-Coffee',
  ];
}
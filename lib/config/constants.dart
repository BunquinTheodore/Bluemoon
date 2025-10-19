class AppConstants {
  // App Info
  static const String appName = 'Bluemoon Coffee';
  static const String appTagline = 'Your Coffee, Delivered Fresh';
  
  // Business Settings
  static const double deliveryFee = 50.0;
  static const double minimumOrder = 100.0;
  static const int estimatedDeliveryTime = 30; // minutes
  
  // Order Status
  static const String orderStatusPending = 'pending';
  static const String orderStatusAccepted = 'accepted';
  static const String orderStatusPreparing = 'preparing';
  static const String orderStatusReady = 'ready';
  static const String orderStatusOutForDelivery = 'out_for_delivery';
  static const String orderStatusDelivered = 'delivered';
  static const String orderStatusCancelled = 'cancelled';
  
  // User Roles
  static const String roleCustomer = 'customer';
  static const String roleAdmin = 'admin';
  static const String roleBarista = 'barista';
  static const String roleRider = 'rider';
  
  // Coffee Sizes
  static const List<String> coffeeSizes = ['Small', 'Medium', 'Large'];
  static const Map<String, double> sizeMultipliers = {
    'Small': 1.0,
    'Medium': 1.3,
    'Large': 1.6,
  };
  
  // Sugar Levels
  static const List<String> sugarLevels = [
    '0%',
    '25%',
    '50%',
    '75%',
    '100%',
    '120%'
  ];
  
  // Ice Levels
  static const List<String> iceLevels = [
    'No Ice',
    'Less Ice',
    'Regular Ice',
    'Extra Ice'
  ];
  
  // Payment Methods
  static const String paymentCOD = 'Cash on Delivery';
  static const String paymentGCash = 'GCash';
  static const String paymentMaya = 'Maya';
  
  // Firebase Collection Names
  static const String usersCollection = 'users';
  static const String productsCollection = 'products';
  static const String ordersCollection = 'orders';
  static const String ridersCollection = 'riders';
  static const String categoriesCollection = 'categories';
  
  // Assets Paths
  static const String logoPath = 'assets/logo.png';
  static const String placeholderImage = 'assets/images/placeholder.png';
  
  // API Keys (TODO: Move to environment variables in production)
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
  
  // Contact Info
  static const String supportEmail = 'support@bluemoon.coffee';
  static const String supportPhone = '+63 XXX XXX XXXX';
}
 import 'package:flutter/material.dart';

import '../models/product.dart';
import '../screens/customer/cart_screen.dart';
import '../screens/customer/checkout_screen.dart';
import '../screens/customer/customer_homescreen.dart';
import '../screens/customer/menu_screen.dart';
import '../screens/customer/ordertracking_screen.dart';
import '../screens/customer/productdetail_screen.dart';
import '../screens/customer/profile_screen.dart';
import '../screens/admin/dashboard_screen.dart';
import '../screens/admin/menu_management_screen.dart';
import '../screens/admin/orders_screen.dart';
import '../screens/admin/analytics_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/splash_screen.dart';

class AppRoutes {
  // Route names
  static const String home = '/home';
  static const String menu = '/menu';
  static const String product = '/product';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orderTracking = '/order-tracking';
  static const String profile = '/profile';
  // Admin routes
  static const String admin = '/admin';
  static const String adminMenu = '/admin/menu';
  static const String adminOrders = '/admin/orders';
  static const String adminAnalytics = '/admin/analytics';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';

  // Optional: basic routes map for simple pages
  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    admin: (context) => const AdminDashboardScreen(),
    adminMenu: (context) => const AdminMenuManagementScreen(),
    adminOrders: (context) => const AdminOrdersScreen(),
    adminAnalytics: (context) => const AdminAnalyticsScreen(),
    home: (context) => const CustomerHomeScreen(),
    menu: (context) => const MenuScreen(),
    cart: (context) => const CartScreen(),
    checkout: (context) => const CheckoutScreen(),
    profile: (context) => const ProfileScreen(),
  };

  // onGenerateRoute to handle pages requiring arguments
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case product:
        final args = settings.arguments;
        if (args is Product) {
          return MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: args),
            settings: settings,
          );
        }
        return _errorRoute('Invalid arguments for $product');
      case orderTracking:
        final args = settings.arguments;
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => OrderTrackingScreen(orderId: args),
            settings: settings,
          );
        }
        return _errorRoute('Invalid arguments for $orderTracking');
      default:
        return null; // Let unknownRoute or default handling take over
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Navigation Error')),
        body: Center(child: Text(message)),
      ),
    );
  }
}

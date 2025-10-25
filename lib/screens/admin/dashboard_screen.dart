import 'package:flutter/material.dart';
import 'package:my_app/config/routes.dart';
import 'package:my_app/config/theme.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _tile(
              context,
              icon: Icons.coffee_maker_outlined,
              title: 'Menu',
              subtitle: 'Manage products & categories',
              route: AppRoutes.adminMenu,
            ),
            _tile(
              context,
              icon: Icons.receipt_long_outlined,
              title: 'Orders',
              subtitle: 'View & update orders',
              route: AppRoutes.adminOrders,
            ),
            _tile(
              context,
              icon: Icons.query_stats_outlined,
              title: 'Analytics',
              subtitle: 'Overview and metrics',
              route: AppRoutes.adminAnalytics,
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String route,
  }) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppTheme.primaryBlue, size: 32),
              const SizedBox(height: 12),
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Text(subtitle, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
            ],
          ),
        ),
      ),
    );
  }
}


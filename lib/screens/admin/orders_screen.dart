import 'package:flutter/material.dart';
import 'package:my_app/config/theme.dart';

class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(title: const Text('Admin • Orders')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 8,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppTheme.primaryBlue.withOpacity(0.1),
                child: const Icon(Icons.receipt_long_outlined, color: AppTheme.primaryBlue),
              ),
              title: Text('Order #${1000 + index}'),
              subtitle: const Text('Status: Pending • Items: 3 • ₱450'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Navigate to order details
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order details coming soon')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

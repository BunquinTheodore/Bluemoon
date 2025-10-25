import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../config/theme.dart';

class OrderTrackingScreen extends StatefulWidget {
  final String orderId;

  const OrderTrackingScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  // TODO: This will be real-time from Firebase later
  String currentStatus = AppConstants.orderStatusPreparing;
  
  final Map<String, String> statusTitles = {
    AppConstants.orderStatusPending: 'Order Received',
    AppConstants.orderStatusAccepted: 'Order Accepted',
    AppConstants.orderStatusPreparing: 'Preparing Your Order',
    AppConstants.orderStatusReady: 'Ready for Pickup',
    AppConstants.orderStatusOutForDelivery: 'Out for Delivery',
    AppConstants.orderStatusDelivered: 'Delivered',
  };

  final Map<String, String> statusDescriptions = {
    AppConstants.orderStatusPending: 'Waiting for confirmation',
    AppConstants.orderStatusAccepted: 'Your order has been confirmed',
    AppConstants.orderStatusPreparing: 'Our baristas are brewing your coffee',
    AppConstants.orderStatusReady: 'Your order is ready',
    AppConstants.orderStatusOutForDelivery: 'Rider is on the way',
    AppConstants.orderStatusDelivered: 'Enjoy your coffee!',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text('Track Order'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildOrderHeader(),
            SizedBox(height: 24),
            _buildStatusTimeline(),
            SizedBox(height: 24),
            _buildDeliveryInfo(),
            SizedBox(height: 16),
            _buildOrderItems(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderHeader() {
    return Container(
      padding: EdgeInsets.all(24),
      color: Colors.white,
      child: Column(
        children: [
          Icon(
            Icons.check_circle,
            size: 80,
            color: AppTheme.success,
          ),
          SizedBox(height: 16),
          Text(
            'Order Placed Successfully!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Order ID: ${widget.orderId}',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time,
                  size: 18,
                  color: AppTheme.primaryBlue,
                ),
                SizedBox(width: 8),
                Text(
                  'Estimated: ${AppConstants.estimatedDeliveryTime} mins',
                  style: TextStyle(
                    color: AppTheme.primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTimeline() {
    final statuses = [
      AppConstants.orderStatusPending,
      AppConstants.orderStatusAccepted,
      AppConstants.orderStatusPreparing,
      AppConstants.orderStatusReady,
      AppConstants.orderStatusOutForDelivery,
      AppConstants.orderStatusDelivered,
    ];

    final currentIndex = statuses.indexOf(currentStatus);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Status',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 20),
          ...List.generate(statuses.length, (index) {
            final status = statuses[index];
            final isCompleted = index <= currentIndex;
            final isCurrent = index == currentIndex;
            final isLast = index == statuses.length - 1;

            return _buildTimelineItem(
              title: statusTitles[status]!,
              description: statusDescriptions[status]!,
              isCompleted: isCompleted,
              isCurrent: isCurrent,
              isLast: isLast,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String description,
    required bool isCompleted,
    required bool isCurrent,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isCompleted ? AppTheme.primaryBlue : Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isCompleted ? Icons.check : Icons.circle,
                color: Colors.white,
                size: 16,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 50,
                color: isCompleted ? AppTheme.primaryBlue : Colors.grey.shade300,
              ),
          ],
        ),
        SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
                    color: isCompleted ? AppTheme.textPrimary : AppTheme.textSecondary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivery Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              SizedBox(height: 16),
              _buildInfoRow(Icons.location_on_outlined, '123 Main St, Manila'),
              SizedBox(height: 12),
              _buildInfoRow(Icons.person_outline, 'Juan Dela Cruz'),
              SizedBox(height: 12),
              _buildInfoRow(Icons.phone_outlined, '+63 912 345 6789'),
              SizedBox(height: 16),
              if (currentStatus == AppConstants.orderStatusOutForDelivery)
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Open map/call rider
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Track on map coming soon!')),
                    );
                  },
                  icon: Icon(Icons.map),
                  label: Text('Track on Map'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppTheme.textSecondary),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItems() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Items',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              SizedBox(height: 16),
              _buildOrderItem('Caramel Macchiato', 'Medium • 50% sugar', 1, 195.0),
              Divider(height: 24),
              _buildOrderItem('Iced Americano', 'Large • Regular Ice', 1, 192.0),
              Divider(height: 24),
              _buildSummaryRow('Subtotal', 387.0),
              SizedBox(height: 8),
              _buildSummaryRow('Delivery Fee', 50.0),
              Divider(height: 24),
              _buildSummaryRow('Total', 437.0, isTotal: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderItem(String name, String details, int quantity, double price) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              SizedBox(height: 4),
              Text(
                details,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Text(
          'x$quantity',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondary,
          ),
        ),
        SizedBox(width: 16),
        Text(
          '₱${price.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: AppTheme.textPrimary,
          ),
        ),
        Text(
          '₱${amount.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: FontWeight.bold,
            color: isTotal ? AppTheme.primaryBlue : AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}
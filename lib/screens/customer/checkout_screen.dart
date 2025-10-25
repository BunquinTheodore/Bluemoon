import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../config/theme.dart';
import '../../config/routes.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String selectedPayment = AppConstants.paymentCOD;
  
  // Form controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final notesController = TextEditingController();

  double subtotal = 350.0; // TODO: Get from cart
  double deliveryFee = AppConstants.deliveryFee;
  double get total => subtotal + deliveryFee;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    subtotal = cart.subtotal;
    deliveryFee = cart.deliveryFee;
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text('Checkout'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Delivery Information'),
                    SizedBox(height: 16),
                    _buildDeliveryForm(),
                    
                    SizedBox(height: 24),
                    _buildSectionTitle('Payment Method'),
                    SizedBox(height: 16),
                    _buildPaymentMethods(),
                    
                    SizedBox(height: 24),
                    _buildSectionTitle('Order Notes (Optional)'),
                    SizedBox(height: 16),
                    _buildNotesField(),
                    
                    SizedBox(height: 24),
                    _buildOrderSummaryCard(cart),
                  ],
                ),
              ),
            ),
          ),
          _buildBottomSection(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppTheme.textPrimary,
      ),
    );
  }

  Widget _buildDeliveryForm() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone_outlined),
                hintText: '+63',
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Delivery Address',
                prefixIcon: Icon(Icons.location_on_outlined),
                suffixIcon: IconButton(
                  icon: Icon(Icons.my_location, color: AppTheme.primaryBlue),
                  onPressed: () {
                    // TODO: Get current location
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Location feature coming soon!')),
                    );
                  },
                ),
              ),
              maxLines: 2,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter delivery address';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Card(
      child: Column(
        children: [
          _buildPaymentOption(
            AppConstants.paymentCOD,
            Icons.money,
            'Cash on Delivery',
          ),
          Divider(height: 1),
          _buildPaymentOption(
            AppConstants.paymentGCash,
            Icons.account_balance_wallet,
            'GCash',
          ),
          Divider(height: 1),
          _buildPaymentOption(
            AppConstants.paymentMaya,
            Icons.credit_card,
            'Maya',
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String value, IconData icon, String label) {
    final isSelected = selectedPayment == value;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppTheme.primaryBlue : AppTheme.textSecondary,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          color: isSelected ? AppTheme.primaryBlue : AppTheme.textPrimary,
        ),
      ),
      trailing: Radio<String>(
        value: value,
        groupValue: selectedPayment,
        onChanged: (String? newValue) {
          setState(() {
            selectedPayment = newValue!;
          });
        },
        activeColor: AppTheme.primaryBlue,
      ),
      onTap: () {
        setState(() {
          selectedPayment = value;
        });
      },
    );
  }

  Widget _buildNotesField() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: TextFormField(
          controller: notesController,
          decoration: InputDecoration(
            hintText: 'Add special instructions for your order...',
            border: InputBorder.none,
          ),
          maxLines: 3,
        ),
      ),
    );
  }

  Widget _buildOrderSummaryCard(CartProvider cart) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            SizedBox(height: 16),
            _buildSummaryRow('Subtotal', cart.subtotal),
            SizedBox(height: 8),
            _buildSummaryRow('Delivery Fee', cart.deliveryFee),
            Divider(height: 24),
            _buildSummaryRow('Total', cart.total, isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: AppTheme.textPrimary,
          ),
        ),
        Text(
          '₱${amount.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: FontWeight.bold,
            color: isTotal ? AppTheme.primaryBlue : AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSection() {
    final cart = context.watch<CartProvider>();
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _placeOrder,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            'Place Order - ₱${cart.total.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _placeOrder() {
    if (_formKey.currentState!.validate()) {
      final cart = context.read<CartProvider>();
      final orders = context.read<OrderProvider>();
      final order = orders.placeOrder(
        items: List.from(cart.items),
        subtotal: cart.subtotal,
        deliveryFee: cart.deliveryFee,
      );
      cart.clear();
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.orderTracking,
        arguments: order.id,
      );
    }
  }
}
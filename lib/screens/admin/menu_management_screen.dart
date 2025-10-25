import 'package:flutter/material.dart';
import 'package:my_app/config/theme.dart';
import 'package:provider/provider.dart';
import 'package:my_app/providers/products_provider.dart';
import 'package:my_app/models/product.dart';

class AdminMenuManagementScreen extends StatefulWidget {
  const AdminMenuManagementScreen({super.key});

  @override
  State<AdminMenuManagementScreen> createState() => _AdminMenuManagementScreenState();
}

class _AdminMenuManagementScreenState extends State<AdminMenuManagementScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductsProvider>().start();
    });
  }

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductsProvider>();
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(title: const Text('Admin • Menu Management')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddOrEditDialog(context),
        child: const Icon(Icons.add),
      ),
      body: products.loading
          ? const Center(child: CircularProgressIndicator())
          : products.error != null
              ? Center(child: Text('Error: ${products.error}'))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: products.products.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final p = products.products[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppTheme.primaryBlue.withOpacity(0.1),
                          backgroundImage: p.imageUrl.isNotEmpty ? NetworkImage(p.imageUrl) : null,
                          child: p.imageUrl.isEmpty
                              ? const Icon(Icons.local_cafe, color: AppTheme.primaryBlue)
                              : null,
                        ),
                        title: Text(p.name),
                        subtitle: Text('${p.category} • ₱${p.price.toStringAsFixed(0)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _showAddOrEditDialog(context, product: p),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: AppTheme.error),
                              onPressed: () async {
                                await context.read<ProductsProvider>().remove(p.id);
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Deleted ${p.name}')),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Future<void> _showAddOrEditDialog(BuildContext context, {Product? product}) async {
    final name = TextEditingController(text: product?.name ?? '');
    final price = TextEditingController(text: product != null ? product.price.toStringAsFixed(0) : '');
    final imageUrl = TextEditingController(text: product?.imageUrl ?? '');
    final category = TextEditingController(text: product?.category ?? 'Hot Coffee');
    final description = TextEditingController(text: product?.description ?? '');
    final availableSizes = product?.availableSizes ?? const ['Small', 'Medium', 'Large'];
    final formKey = GlobalKey<FormState>();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(product == null ? 'Add Product' : 'Edit Product'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: name,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: price,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Price (₱)'),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Required';
                    final val = double.tryParse(v);
                    if (val == null) return 'Enter a number';
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: category,
                  decoration: const InputDecoration(labelText: 'Category'),
                  validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: imageUrl,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                  validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: description,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;
              Navigator.pop(context, true);
            },
            child: Text(product == null ? 'Add' : 'Save'),
          ),
        ],
      ),
    );

    if (result != true) return;
    final p = Product(
      id: product?.id ?? '',
      name: name.text.trim(),
      description: description.text.trim(),
      price: double.parse(price.text.trim()),
      imageUrl: imageUrl.text.trim(),
      category: category.text.trim(),
      availableSizes: availableSizes,
      isAvailable: true,
    );
    if (product == null) {
      await context.read<ProductsProvider>().add(p);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added ${p.name}')),
      );
    } else {
      await context.read<ProductsProvider>().update(p);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Updated ${p.name}')),
      );
    }
  }
}


import 'package:flutter/material.dart';

import '../../../app/admin_services.dart';
import '../../../core/widgets/common.dart';
import '../../catalog/view/banner_page.dart';
import '../../catalog/view/categories_page.dart';
import '../../catalog/view/products_page.dart';
import '../../orders/view/orders_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int page = 0;
  static const titles = ['Products', 'Categories', 'Orders', 'Banner'];
  Future<void> _importCatalog() async {
    final proceed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Import existing catalog?'),
        content: const Text(
          'Copy the saved categories, products, and banner into this Firebase project. Import is available only while the catalog is empty.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Import'),
          ),
        ],
      ),
    );
    if (proceed != true || !mounted) return;
    try {
      await AdminScope.of(context).catalog.importInitialCatalog();
      if (mounted) showMessage(context, 'Catalog imported successfully.');
    } catch (error) {
      if (mounted) showMessage(context, 'Could not import catalog: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final services = AdminScope.of(context);
    final pages = [
      ProductsPage(viewModel: services.catalog),
      CategoriesPage(viewModel: services.catalog),
      OrdersPage(viewModel: services.orders),
      BannerPage(viewModel: services.catalog),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Shoply Admin · ${titles[page]}'),
        actions: [
          IconButton(
            tooltip: 'Import existing catalog',
            onPressed: _importCatalog,
            icon: const Icon(Icons.file_download_outlined),
          ),
          IconButton(
            tooltip: 'Sign out',
            onPressed: services.auth.signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: pages[page],
      bottomNavigationBar: NavigationBar(
        selectedIndex: page,
        onDestinationSelected: (index) => setState(() => page = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            label: 'Products',
          ),
          NavigationDestination(
            icon: Icon(Icons.category_outlined),
            label: 'Categories',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.image_outlined),
            label: 'Banner',
          ),
        ],
      ),
    );
  }
}

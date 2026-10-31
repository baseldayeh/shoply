import 'package:flutter/material.dart';

import '../../../core/models/catalog.dart';
import '../../../core/widgets/common.dart';
import '../view_model/catalog_view_model.dart';
import 'product_editor.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key, required this.viewModel});
  final CatalogViewModel viewModel;
  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButton: FloatingActionButton.extended(
      onPressed: () => showDialog<void>(
        context: context,
        builder: (_) => ProductEditor(viewModel: viewModel),
      ),
      icon: const Icon(Icons.add),
      label: const Text('Add product'),
    ),
    body: ListStreamView<Product>(
      stream: viewModel.watchProducts(),
      empty: 'No products yet. Add a category and then a product.',
      builder: (products) => ListView.builder(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 90),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: ListTile(
              leading: Thumbnail(
                product.images.isEmpty ? '' : product.images.first,
              ),
              title: Text(product.name),
              subtitle: Text(
                '\$${product.price.toStringAsFixed(2)}${product.isTrending ? '  ·  Trending' : ''}',
              ),
              onTap: () => showDialog<void>(
                context: context,
                builder: (_) =>
                    ProductEditor(viewModel: viewModel, product: product),
              ),
              trailing: IconButton(
                tooltip: 'Delete',
                icon: const Icon(Icons.delete_outline),
                onPressed: () async {
                  if (!await confirmDelete(context, 'product')) return;
                  try {
                    await viewModel.deleteProduct(product);
                  } catch (error) {
                    if (context.mounted) {
                      showMessage(context, 'Could not delete product: $error');
                    }
                  }
                },
              ),
            ),
          );
        },
      ),
    ),
  );
}

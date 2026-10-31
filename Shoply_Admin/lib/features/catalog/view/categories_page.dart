import 'package:flutter/material.dart';

import '../../../core/models/catalog.dart';
import '../../../core/widgets/common.dart';
import '../view_model/catalog_view_model.dart';
import 'category_editor.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key, required this.viewModel});
  final CatalogViewModel viewModel;
  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButton: FloatingActionButton.extended(
      onPressed: () => showDialog<void>(
        context: context,
        builder: (_) => CategoryEditor(viewModel: viewModel),
      ),
      icon: const Icon(Icons.add),
      label: const Text('Add category'),
    ),
    body: ListStreamView<Category>(
      stream: viewModel.watchCategories(),
      empty: 'No categories yet. Add one to get started.',
      builder: (categories) => ListView.builder(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 90),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Card(
            child: ListTile(
              leading: Thumbnail(category.imageUrl),
              title: Text(category.name),
              subtitle: Text(category.id),
              onTap: () => showDialog<void>(
                context: context,
                builder: (_) =>
                    CategoryEditor(viewModel: viewModel, category: category),
              ),
              trailing: IconButton(
                tooltip: 'Delete',
                icon: const Icon(Icons.delete_outline),
                onPressed: () async {
                  if (!await confirmDelete(context, 'category')) return;
                  try {
                    await viewModel.deleteCategory(category.id);
                  } catch (error) {
                    if (context.mounted) {
                      showMessage(context, 'Could not delete category: $error');
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

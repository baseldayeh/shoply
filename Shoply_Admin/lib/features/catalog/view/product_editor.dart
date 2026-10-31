import 'package:flutter/material.dart';

import '../../../core/models/catalog.dart';
import '../../../core/widgets/common.dart';
import '../view_model/catalog_view_model.dart';

class ProductEditor extends StatefulWidget {
  const ProductEditor({super.key, required this.viewModel, this.product});
  final CatalogViewModel viewModel;
  final Product? product;
  @override
  State<ProductEditor> createState() => _ProductEditorState();
}

class _ProductEditorState extends State<ProductEditor> {
  final form = GlobalKey<FormState>();
  late final TextEditingController name, description, price, image;
  late final Stream<List<Category>> categories;
  String? categoryId;
  bool trending = false, saving = false;
  @override
  void initState() {
    super.initState();
    final product = widget.product;
    categories = widget.viewModel.watchCategories();
    name = TextEditingController(text: product?.name ?? '');
    description = TextEditingController(text: product?.description ?? '');
    price = TextEditingController(text: product?.price.toString() ?? '');
    image = TextEditingController(
      text: product?.images.isNotEmpty == true ? product!.images.first : '',
    );
    categoryId = product?.categoryId;
    trending = product?.isTrending ?? false;
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    price.dispose();
    image.dispose();
    super.dispose();
  }

  Future<void> save() async {
    if (!form.currentState!.validate() || categoryId == null || saving) return;
    setState(() => saving = true);
    final images = List<String>.of(widget.product?.images ?? const []);
    if (images.isEmpty) {
      images.add(image.text.trim());
    } else {
      images[0] = image.text.trim();
    }
    try {
      await widget.viewModel.saveProduct(
        Product(
          id: widget.product?.id ?? '',
          categoryId: categoryId!,
          name: name.text.trim(),
          description: description.text.trim(),
          price: double.parse(price.text.trim()),
          images: images,
          isTrending: trending,
        ),
      );
      if (mounted) Navigator.pop(context);
    } catch (error) {
      if (mounted) {
        showMessage(context, 'Could not save: $error');
        setState(() => saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.product == null ? 'New product' : 'Edit product'),
    content: SizedBox(
      width: 420,
      child: SingleChildScrollView(
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StreamBuilder<List<Category>>(
                stream: categories,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Unable to load categories.');
                  }
                  final categories = snapshot.data ?? [];
                  return DropdownButtonFormField<String>(
                    initialValue:
                        categories.any((category) => category.id == categoryId)
                        ? categoryId
                        : null,
                    decoration: const InputDecoration(labelText: 'Category'),
                    items: categories
                        .map(
                          (category) => DropdownMenuItem(
                            value: category.id,
                            child: Text(
                              category.name,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: widget.product == null
                        ? (value) => setState(() => categoryId = value)
                        : null,
                    validator: (_) =>
                        categoryId == null ? 'Choose a category' : null,
                  );
                },
              ),
              TextFormField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: widget.viewModel.requiredText,
              ),
              TextFormField(
                controller: description,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: widget.viewModel.requiredText,
              ),
              TextFormField(
                controller: price,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'Price'),
                validator: widget.viewModel.validatePrice,
              ),
              TextFormField(
                controller: image,
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: widget.viewModel.validateImageUrl,
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Show in trending'),
                value: trending,
                onChanged: (value) => setState(() => trending = value),
              ),
            ],
          ),
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: saving ? null : () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      FilledButton(
        onPressed: saving ? null : save,
        child: Text(saving ? 'Saving…' : 'Save'),
      ),
    ],
  );
}

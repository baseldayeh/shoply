import 'package:flutter/material.dart';

import '../../../core/models/catalog.dart';
import '../../../core/widgets/common.dart';
import '../view_model/catalog_view_model.dart';

class CategoryEditor extends StatefulWidget {
  const CategoryEditor({super.key, required this.viewModel, this.category});
  final CatalogViewModel viewModel;
  final Category? category;
  @override
  State<CategoryEditor> createState() => _CategoryEditorState();
}

class _CategoryEditorState extends State<CategoryEditor> {
  final form = GlobalKey<FormState>();
  late final TextEditingController name, image;
  bool saving = false;
  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.category?.name ?? '');
    image = TextEditingController(text: widget.category?.imageUrl ?? '');
  }

  @override
  void dispose() {
    name.dispose();
    image.dispose();
    super.dispose();
  }

  Future<void> save() async {
    if (!form.currentState!.validate() || saving) return;
    setState(() => saving = true);
    try {
      await widget.viewModel.saveCategory(
        Category(
          id: widget.category?.id ?? '',
          name: name.text.trim(),
          imageUrl: image.text.trim(),
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
    title: Text(widget.category == null ? 'New category' : 'Edit category'),
    content: SingleChildScrollView(
      child: Form(
        key: form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: name,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: widget.viewModel.requiredText,
            ),
            TextFormField(
              controller: image,
              decoration: const InputDecoration(labelText: 'Image URL'),
              validator: widget.viewModel.validateImageUrl,
            ),
          ],
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

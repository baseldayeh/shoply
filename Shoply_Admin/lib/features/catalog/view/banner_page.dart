import 'package:flutter/material.dart';

import '../../../core/models/catalog.dart';
import '../../../core/widgets/common.dart';
import '../view_model/catalog_view_model.dart';

class BannerPage extends StatelessWidget {
  const BannerPage({super.key, required this.viewModel});
  final CatalogViewModel viewModel;
  @override
  Widget build(BuildContext context) => StreamBuilder<StoreBanner?>(
    stream: viewModel.watchBanner(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return const Center(child: Text('Could not load the banner.'));
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      final banner = snapshot.data;
      return ListView(
        children: [
          if (banner != null)
            ListTile(
              leading: Thumbnail(banner.imageUrl),
              title: const Text('Store banner'),
              subtitle: Text(banner.imageUrl),
              onTap: () => showDialog<void>(
                context: context,
                builder: (_) =>
                    BannerEditor(viewModel: viewModel, banner: banner),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton.icon(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (_) =>
                    BannerEditor(viewModel: viewModel, banner: banner),
              ),
              icon: const Icon(Icons.edit),
              label: Text(banner == null ? 'Add banner' : 'Edit banner'),
            ),
          ),
        ],
      );
    },
  );
}

class BannerEditor extends StatefulWidget {
  const BannerEditor({super.key, required this.viewModel, this.banner});
  final CatalogViewModel viewModel;
  final StoreBanner? banner;
  @override
  State<BannerEditor> createState() => _BannerEditorState();
}

class _BannerEditorState extends State<BannerEditor> {
  final form = GlobalKey<FormState>();
  late final TextEditingController image;
  bool saving = false;
  @override
  void initState() {
    super.initState();
    image = TextEditingController(text: widget.banner?.imageUrl ?? '');
  }

  @override
  void dispose() {
    image.dispose();
    super.dispose();
  }

  Future<void> save() async {
    if (!form.currentState!.validate() || saving) return;
    setState(() => saving = true);
    try {
      await widget.viewModel.saveBanner(
        StoreBanner(id: widget.banner?.id ?? '', imageUrl: image.text.trim()),
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
    title: const Text('Store banner'),
    content: Form(
      key: form,
      child: TextFormField(
        controller: image,
        decoration: const InputDecoration(labelText: 'Image URL'),
        validator: widget.viewModel.validateImageUrl,
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

import 'package:flutter/material.dart';

void showMessage(BuildContext context, String text) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

Future<bool> confirmDelete(BuildContext context, String label) async =>
    await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete $label?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    ) ??
    false;

class Thumbnail extends StatelessWidget {
  const Thumbnail(this.url, {super.key});
  final String url;
  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: SizedBox(
      width: 52,
      height: 52,
      child: url.isEmpty
          ? const Icon(Icons.image_outlined)
          : Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) =>
                  const Icon(Icons.broken_image_outlined),
            ),
    ),
  );
}

class ListStreamView<T> extends StatelessWidget {
  const ListStreamView({
    super.key,
    required this.stream,
    required this.empty,
    required this.builder,
  });
  final Stream<List<T>> stream;
  final String empty;
  final Widget Function(List<T>) builder;
  @override
  Widget build(BuildContext context) => StreamBuilder<List<T>>(
    stream: stream,
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Unable to load data: ${snapshot.error}',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      if (!snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.data!.isEmpty) {
        return Center(child: Text(empty, textAlign: TextAlign.center));
      }
      return builder(snapshot.data!);
    },
  );
}

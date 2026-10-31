import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key, required this.emptyText});
  final String emptyText;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        emptyText,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
    );
  }
}

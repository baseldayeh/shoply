import 'package:flutter/material.dart';
import 'package:pro_dialog/pro_dialog.dart';

class CustomSuccessDialog extends StatelessWidget {
  const CustomSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  static void showProSuccessDialog({
    required BuildContext context,
    required String title,
    required String description,
    required void Function() onPressed,
  }) {
    showProDialog(
      context,
      type: DialogType.success,
      title: title,
      description: description,
      buttons: [
        DialogButton(text: 'Got it', isPrimary: true, onPressed: onPressed),
      ],
    );
  }
}

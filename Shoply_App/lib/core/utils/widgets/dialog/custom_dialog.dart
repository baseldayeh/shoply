import 'package:flutter/material.dart';
import 'package:pro_dialog/pro_dialog.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  static void showCustomProDialog({
    required BuildContext context,
    required String title,
    required String description,
    void Function()? onPressed,
    required DialogType dialogType,
    required Color iconBackgroundColor,
    required Color iconColor,
    required IconData icon,
    List<DialogButton>? buttons,
  }) {
    showProDialog(
      context,
      type: dialogType,
      iconBackgroundColor: iconBackgroundColor,
      iconColor: iconColor,
      icon: icon,
      title: title,
      description: description,
      buttons:
          buttons ??
          [
            DialogButton(
              text: 'Got it',
              isPrimary: true,
              onPressed: onPressed ?? () {},
            ),
          ],
    );
  }
}

import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    required this.iconData,
    this.color,
    this.onTap,
  });
  final String title;
  final IconData iconData;
  final Color? color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          iconData,
          size: 30,
          color: color ?? theme.listTileTheme.iconColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: color ?? theme.listTileTheme.textColor,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.titleText,
    this.actions,
    this.actionsPadding,
    this.leading,
    this.title,
  });
  final String? titleText;
  final List<Widget>? actions;
  final Widget? leading;
  final EdgeInsetsGeometry? actionsPadding;
  final Widget? title;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      actionsPadding: actionsPadding,
      actions: actions,
      leading: leading,
      title: title ?? Text(titleText ?? '', style: theme.textTheme.bodyMedium),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

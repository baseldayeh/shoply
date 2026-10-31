part of '../settings_screen.dart';

class _RowIcon extends StatelessWidget {
  const _RowIcon({required this.title, required this.iconData, this.onTap});
  final String title;
  final IconData iconData;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(iconData, size: 25, color: theme.iconTheme.color),
          SizedBox(width: 20),
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 18),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, size: 22, color: theme.iconTheme.color),
          SizedBox(width: 5),
        ],
      ),
    );
  }
}

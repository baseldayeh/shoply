part of '../../main_screen.dart';

class _MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _MainAppBar();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomAppBar(
      title: Wrap(
        children: [
          Text('Shop', style: theme.textTheme.bodyMedium),
          Text(
            'ly',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
              fontStyle: FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

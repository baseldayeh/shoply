part of '../../main_screen.dart';

class _MainDrawer extends StatelessWidget {
  const _MainDrawer();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MainCubit>();
    return Drawer(
      width: (MediaQuery.sizeOf(context).width * .88).clamp(0.0, 330.0),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                SizedBox(height: 15),
                Row(
                  spacing: 15,
                  children: [
                    Container(
                      height: 95,
                      width: 95,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: CustomCachedImageNetwork(
                        errorWidget: Image(
                          image: AssetImage(AppImages.profilePicture),
                        ),
                        image: LocalStorageUser.instance.profileImage,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 6,
                        children: [
                          Text(
                            LocalStorageUser.instance.fullName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            LocalStorageUser.instance.email,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(thickness: 0.1, color: Colors.grey),
                SizedBox(height: 20),
                CustomListTile(
                  iconData: Icons.shopping_bag_outlined,
                  title: 'My Orders',
                ),
                SizedBox(height: 20),
                CustomListTile(
                  onTap: () {
                    Navigator.pushNamed(context, AppPages.settingsScreen);
                  },
                  iconData: Icons.settings_outlined,
                  title: 'Settings',
                ),
                SizedBox(height: 20),
                CustomListTile(iconData: Icons.info_outline, title: 'About'),
                SizedBox(height: 30),
                CustomListTile(
                  onTap: () {
                    CustomDialog.showCustomProDialog(
                      context: context,
                      title: 'Logout',
                      description: 'Are you sure you want to log out?',
                      dialogType: DialogType.error,
                      iconBackgroundColor: Colors.red,
                      iconColor: Colors.white,
                      icon: Icons.logout,
                      buttons: [
                        DialogButton(
                          text: 'Cancel',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        DialogButton(
                          text: 'Logout',
                          isPrimary: true,
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppPages.loginScreen,
                              (route) => false,
                            );
                            cubit.logout();
                          },
                        ),
                      ],
                    );
                  },
                  iconData: Icons.logout,
                  title: 'Logout',
                  color: Colors.red,
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

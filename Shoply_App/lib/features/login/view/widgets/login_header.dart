part of '../login_screen.dart';

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage(AppImages.shoplySplashImage),
          height: 200,
          width: 240,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 10),
        Text(
          'Welcom Back',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        Text(
          'Sign to countinue shopping',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

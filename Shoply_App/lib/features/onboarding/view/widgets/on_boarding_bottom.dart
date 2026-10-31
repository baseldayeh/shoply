part of '../on_boarding_screen.dart';

class _OnBoardingBottom extends StatelessWidget {
  const _OnBoardingBottom();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: BlocBuilder<OnBoardingCubit, OnBoardingState>(
        buildWhen: (previous, current) {
          return current is OnBoardingChangeIndexState;
        },
        builder: (context, state) {
          final cubit = context.read<OnBoardingCubit>();
          return Column(
            children: [
              CustomSmoothIndicator(
                pageController: cubit.pageController,
                count: 3,
              ),
              SizedBox(height: 55),
              Column(
                children: [
                  CustomButton(
                    buttonText: cubit.index != 2 ? 'Next' : 'Get Started',
                    onPressed: cubit.index != 2
                        ? () {
                            cubit.nextPageController();
                          }
                        : () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppPages.loginScreen,
                              (route) => false,
                            );
                            cubit.setShowOnBoard();
                          },
                  ),
                  SizedBox(height: 20),
                  if (cubit.index != 2)
                    CustomTextButton(
                      onTap: () {
                        cubit.skipOnBoard();
                      },
                      textButton: 'Skip',
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

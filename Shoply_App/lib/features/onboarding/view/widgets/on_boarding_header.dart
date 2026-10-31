part of '../on_boarding_screen.dart';

class _OnBoardingHeader extends StatelessWidget {
  const _OnBoardingHeader();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      buildWhen: (previous, current) {
        return current is! OnBoardingChangeIndexState;
      },
      builder: (context, state) {
        final cubit = context.read<OnBoardingCubit>();
        return PageView.builder(
          onPageChanged: (index) {
            cubit.changeIndex(index: index);
          },
          controller: cubit.pageController,
          itemCount: 3,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(cubit.onBoardImage[index]),
                    height: (MediaQuery.sizeOf(context).height * .36).clamp(
                      140.0,
                      330.0,
                    ),
                    width: double.infinity,
                  ),
                  SizedBox(height: 10),
                  Text(
                    cubit.onBoardTitle[index],
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    cubit.onBoardDescreption[index],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

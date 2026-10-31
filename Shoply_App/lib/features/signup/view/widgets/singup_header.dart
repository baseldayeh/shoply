part of '../signup_screen.dart';

class _SingupHeader extends StatelessWidget {
  const _SingupHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Join us and start shopping',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 20),
        BlocBuilder<SignupCubit, SignupState>(
          buildWhen: (previous, current) {
            return current is SingupPickImageState ||
                current is SingupRemoveImageState;
          },
          builder: (context, state) {
            final cubit = context.read<SignupCubit>();
            return Stack(
              alignment: AlignmentGeometry.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.transparent,
                  backgroundImage:
                      cubit.image == null || (cubit.image?.path.isEmpty ?? true)
                      ? AssetImage(AppImages.profilePicture)
                      : FileImage(cubit.image!),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      cubit.pickImage();
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                      child: Icon(
                        Icons.camera_alt_sharp,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                cubit.image == null || (cubit.image?.path.isEmpty ?? true)
                    ? SizedBox.shrink()
                    : Positioned(
                        bottom: 5,
                        left: 5,
                        child: GestureDetector(
                          onTap: () {
                            cubit.deleteImage();
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.error,
                            ),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
              ],
            );
          },
        ),
      ],
    );
  }
}

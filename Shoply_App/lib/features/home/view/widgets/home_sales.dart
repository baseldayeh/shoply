part of '../home_screen.dart';

class _HomeSales extends StatelessWidget {
  const _HomeSales();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    if (cubit.responseSales?.image == null ||
        cubit.responseSales!.image!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: CustomCachedImageNetwork(
        fit: BoxFit.cover,
        image: cubit.responseSales?.image ?? '',
        errorWidget: const _BannerFallback(),
      ),
    );
  }
}

class _BannerFallback extends StatelessWidget {
  const _BannerFallback();
  @override
  Widget build(BuildContext context) => Container(
    color: const Color(0xffe6f2eb),
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discover your style',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff005b45),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Explore the collection',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Image.asset(
            AppImages.onboardImage2,
            fit: BoxFit.contain,
            height: double.infinity,
          ),
        ),
      ],
    ),
  );
}

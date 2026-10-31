part of '../home_screen.dart';

class _HomeCategories extends StatelessWidget {
  const _HomeCategories();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Column(
      children: [
        CustomViewAll(
          text: 'Categories',
          onTapViewAll: () {
            Navigator.pushNamed(
              context,
              AppPages.categoriesScreen,
              arguments: context,
            );
          },
        ),
        SizedBox(
          height: 170,
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(width: 10);
            },
            scrollDirection: Axis.horizontal,
            itemCount: cubit.ressponseCategories.length,
            padding: EdgeInsets.symmetric(horizontal: 12),
            itemBuilder: (context, index) {
              final categoryData = cubit.ressponseCategories[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppPages.productsScreen,
                    arguments: {
                      'titleText': categoryData.name,
                      'categoryId': categoryData.id,
                      'context': context,
                    },
                  );
                },
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey.shade200,
                      ),
                      child: CustomCachedImageNetwork(
                        height: 100,
                        fit: BoxFit.contain,
                        width: 120,
                        image: categoryData.image ?? '',
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      categoryData.name ?? '',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

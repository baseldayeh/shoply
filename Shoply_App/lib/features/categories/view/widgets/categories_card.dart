part of '../categories_screen.dart';

class _CategoriesCard extends StatelessWidget {
  const _CategoriesCard();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CategoriesCubit>();
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 12),
      separatorBuilder: (context, index) {
        return SizedBox(height: 8);
      },
      itemCount: cubit.ressponseCategories.length,
      itemBuilder: (context, index) {
        final categoriesData = cubit.ressponseCategories[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppPages.productsScreen,
              arguments: {
                'titleText': categoriesData.name,
                'categoryId': categoriesData.id,
                'context': context,
              },
            );
          },
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    CustomCachedImageNetwork(
                      height: 120,
                      width: 100,
                      fit: BoxFit.contain,
                      image: categoriesData.image ?? '',
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        categoriesData.name ?? '',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 22),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

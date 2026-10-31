part of '../favourite_screen.dart';

class _FavouriteGrid extends StatelessWidget {
  const _FavouriteGrid();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavouriteCubit>();
    return GridView.builder(
      itemCount: cubit.responseProducts.length,
      padding: EdgeInsets.symmetric(horizontal: 12),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 240,
        mainAxisExtent: 210 + MediaQuery.textScalerOf(context).scale(62),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final favouriteData = cubit.responseProducts[index];
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.grey.shade100),
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      CustomCachedImageNetwork(
                        fit: BoxFit.contain,
                        image: favouriteData.images.isEmpty
                            ? ''
                            : favouriteData.images.first,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        child: Align(
                          alignment: AlignmentGeometry.topRight,
                          child: GestureDetector(
                            onTap: () {
                              cubit.removeProductFromFav(
                                context: context,
                                productId: favouriteData.id ?? '',
                              );
                            },
                            child: Icon(
                              Icons.favorite,
                              size: 28,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      favouriteData.name ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$ ${favouriteData.price}',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomButton(
                  radius: 12,
                  height: 52,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                  buttonText: 'Add to Cart',
                  onPressed: () {
                    cubit.addToCart(
                      requestCart: Cart(
                        id: favouriteData.id,
                        name: favouriteData.name,
                        price: favouriteData.price,
                        quantity: 1,
                        images: favouriteData.images,
                      ),
                      context: context,
                    );
                  },
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}

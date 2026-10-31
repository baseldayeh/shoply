part of '../product_details_screen.dart';

class _ProductDetailsBottom extends StatelessWidget {
  const _ProductDetailsBottom({required this.responseProducts});
  final ResponseProducts responseProducts;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    return Column(
      children: [
        Align(
          alignment: AlignmentGeometry.centerLeft,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 52,
            width: 190,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1),
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      cubit.decrementQuantity();
                    },
                    child: Icon(Icons.remove, size: 25),
                  ),
                ),
                VerticalDivider(color: Colors.grey.shade300),
                Expanded(
                  child: Center(
                    child:
                        BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                          buildWhen: (previous, current) {
                            return current is ProductDetailsChangeQuantityState;
                          },
                          builder: (context, state) {
                            final cubit = context.read<ProductDetailsCubit>();
                            return Text(
                              cubit.quantity.toString(),
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            );
                          },
                        ),
                  ),
                ),
                VerticalDivider(color: Colors.grey.shade300),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      cubit.incrementQuantity();
                    },
                    child: Icon(Icons.add, size: 25),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomButton(
            buttonText: 'Add to Cart',
            onPressed: () {
              cubit.addToCart(
                context: context,
                requestCart: Cart(
                  id: responseProducts.id,
                  name: responseProducts.name,
                  price: responseProducts.price,
                  quantity: cubit.quantity,
                  images: responseProducts.images,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

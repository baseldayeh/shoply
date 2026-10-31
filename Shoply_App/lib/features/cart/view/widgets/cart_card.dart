part of '../cart_screen.dart';

class _CartCard extends StatelessWidget {
  const _CartCard();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    return ListView.separated(
      separatorBuilder: (context, index) {
        return SizedBox(height: 5);
      },
      itemCount: cubit.responseCart.length,
      itemBuilder: (context, index) {
        final cartData = cubit.responseCart[index];
        return Dismissible(
          key: ValueKey(cartData.id),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            cubit.deleteProduct(productId: cartData.id ?? '', context: context);
          },
          background: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: AlignmentDirectional.centerEnd,
            child: const Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 30,
            ),
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: CustomCachedImageNetwork(
                  width: (MediaQuery.sizeOf(context).width * .27).clamp(
                    60.0,
                    120.0,
                  ),
                  fit: BoxFit.contain,
                  image: cartData.images?.isNotEmpty == true
                      ? cartData.images!.first
                      : '',
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartData.name ?? '',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      '\$ ${cartData.price}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 15),
                    Align(
                      alignment: AlignmentGeometry.centerLeft,
                      child: Container(
                        height: 45,
                        width: 155,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  cubit.decrementQuantity(index: index);
                                },
                                child: Icon(Icons.remove, size: 25),
                              ),
                            ),
                            VerticalDivider(color: Colors.grey.shade300),
                            Expanded(
                              child: Center(
                                child: Text(
                                  cartData.quantity.toString(),
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            VerticalDivider(color: Colors.grey.shade300),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  cubit.incrementQuantity(index: index);
                                },
                                child: Icon(Icons.add, size: 25),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  cubit.deleteProduct(
                    productId: cartData.id ?? '',
                    context: context,
                  );
                },
                child: Icon(Icons.delete_outlined, size: 26, color: Colors.red),
              ),
              SizedBox(width: 15),
            ],
          ),
        );
      },
    );
  }
}

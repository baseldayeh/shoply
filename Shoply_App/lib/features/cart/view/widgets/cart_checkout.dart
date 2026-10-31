part of '../cart_screen.dart';

class _CartCheckout extends StatelessWidget {
  const _CartCheckout();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    return CartCheckoutPanel(
      total: cubit.subTotal,
      onCheckout: () => cubit.checkOut(context: context),
    );
  }
}

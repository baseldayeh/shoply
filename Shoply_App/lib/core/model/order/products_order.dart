import 'package:shoply_app/core/model/cart/cart.dart';

class ProductsOrder {
  String? id;
  final String? userUid;
  final String? fullName;
  final String? address;
  final double? subTotal;
  final String? status;
  final List<Cart>? cart;

  ProductsOrder({
    this.id,
    required this.userUid,
    required this.fullName,
    required this.address,
    required this.subTotal,
    required this.cart,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userUid': userUid,
      'fullName': fullName,
      'address': address,
      'subTotal': subTotal,
      'status': status,
      'cart': cart?.map((cart) => cart.toJson()).toList(),
    };
  }
}

import 'package:flutter/widgets.dart';

import '../features/auth/view_model/auth_view_model.dart';
import '../features/catalog/view_model/catalog_view_model.dart';
import '../features/orders/view_model/orders_view_model.dart';

class AdminServices {
  const AdminServices({
    required this.auth,
    required this.catalog,
    required this.orders,
  });
  final AuthViewModel auth;
  final CatalogViewModel catalog;
  final OrdersViewModel orders;
}

class AdminScope extends InheritedWidget {
  const AdminScope({super.key, required this.services, required super.child});
  final AdminServices services;
  static AdminServices of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AdminScope>()!.services;
  @override
  bool updateShouldNotify(AdminScope oldWidget) =>
      services != oldWidget.services;
}

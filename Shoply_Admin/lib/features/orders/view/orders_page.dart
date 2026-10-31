import 'package:flutter/material.dart';

import '../../../core/models/store_order.dart';
import '../../../core/widgets/common.dart';
import '../view_model/orders_view_model.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key, required this.viewModel});
  final OrdersViewModel viewModel;
  @override
  Widget build(BuildContext context) => ListStreamView<StoreOrder>(
    stream: viewModel.watchOrders(),
    empty: 'No orders yet.',
    builder: (orders) => ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: ExpansionTile(
            title: Text(order.customerName),
            subtitle: Text('Order ${order.id} · ${order.status}'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Address: ${order.address}'),
                    Text('Total: \$${order.total.toStringAsFixed(2)}'),
                    for (final item in order.items)
                      Text('${item.name} × ${item.quantity}'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: OrdersViewModel.statuses
                          .map(
                            (status) => OutlinedButton(
                              onPressed: () async {
                                try {
                                  await viewModel.setStatus(order.id, status);
                                } catch (error) {
                                  if (context.mounted) {
                                    showMessage(
                                      context,
                                      'Could not update order: $error',
                                    );
                                  }
                                }
                              },
                              child: Text(status),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

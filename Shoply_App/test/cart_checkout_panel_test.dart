import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shoply_app/features/cart/view/widgets/cart_checkout_panel.dart';

void main() {
  for (final width in [320.0, 390.0, 600.0]) {
    testWidgets(
      'checkout fits a $width logical pixel screen with larger text',
      (tester) async {
        tester.view.physicalSize = Size(width, 568);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        var tapped = false;
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(textScaler: TextScaler.linear(1.5)),
              child: Scaffold(
                body: Column(
                  children: [
                    const Expanded(child: SizedBox()),
                    CartCheckoutPanel(
                      total: 500,
                      onCheckout: () => tapped = true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        expect(find.text('Checkout'), findsOneWidget);
        expect(tester.takeException(), isNull);
        await tester.tap(find.text('Checkout'));
        expect(tapped, isTrue);
      },
    );
  }
}

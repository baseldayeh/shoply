import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shoply_admin/features/auth/data/auth_repository.dart';
import 'package:shoply_admin/features/auth/view/login_screen.dart';
import 'package:shoply_admin/features/auth/view_model/auth_view_model.dart';

class FakeAuthRepository implements AuthRepository {
  final users = StreamController<String?>.broadcast();
  final admins = StreamController<bool>.broadcast();
  String? email;
  @override
  Stream<String?> get userIds => users.stream;
  @override
  Stream<bool> watchAdmin(String uid) => admins.stream;
  @override
  Future<void> signIn(String email, String password) async {
    this.email = email;
  }

  @override
  Future<void> signOut() async {
    users.add(null);
  }
}

void main() {
  test('auth view model grants access only after the admin check', () async {
    final repo = FakeAuthRepository();
    final vm = AuthViewModel(repo);
    repo.users.add('user');
    await Future<void>.delayed(Duration.zero);
    expect(vm.status, AuthStatus.loading);
    repo.admins.add(false);
    await Future<void>.delayed(Duration.zero);
    expect(vm.status, AuthStatus.denied);
    repo.admins.add(true);
    await Future<void>.delayed(Duration.zero);
    expect(vm.status, AuthStatus.authorized);
    await vm.signOut();
    await Future<void>.delayed(Duration.zero);
    expect(vm.status, AuthStatus.signedOut);
    vm.dispose();
    await repo.users.close();
    await repo.admins.close();
  });

  testWidgets(
    'admin sign-in remains usable on a small screen with large text',
    (tester) async {
      final repo = FakeAuthRepository();
      final vm = AuthViewModel(repo);
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(1.6)),
            child: LoginScreen(viewModel: vm),
          ),
        ),
      );
      expect(find.text('Shoply Admin'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
      await tester.ensureVisible(find.text('Sign in'));
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      vm.dispose();
      await repo.users.close();
      await repo.admins.close();
    },
  );
}

import 'package:flutter/material.dart';

import '../../../app/admin_services.dart';
import '../../dashboard/view/dashboard_screen.dart';
import '../view_model/auth_view_model.dart';
import 'login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  @override
  Widget build(BuildContext context) {
    final vm = AdminScope.of(context).auth;
    return AnimatedBuilder(
      animation: vm,
      builder: (context, _) {
        switch (vm.status) {
          case AuthStatus.loading:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          case AuthStatus.signedOut:
            return LoginScreen(viewModel: vm);
          case AuthStatus.authorized:
            return const DashboardScreen();
          case AuthStatus.denied:
          case AuthStatus.error:
            return Scaffold(
              appBar: AppBar(title: const Text('Access unavailable')),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.lock_outline, size: 48),
                      const SizedBox(height: 16),
                      Text(
                        vm.status == AuthStatus.error
                            ? 'Could not check administrator access. Check your connection and try again.'
                            : 'This account is not an administrator. Ask the project owner to grant access.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      FilledButton.tonal(
                        onPressed: vm.signOut,
                        child: const Text('Sign out'),
                      ),
                    ],
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}

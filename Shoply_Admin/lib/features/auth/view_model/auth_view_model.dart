import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/auth_repository.dart';

enum AuthStatus { loading, signedOut, authorized, denied, error }

class AuthViewModel extends ChangeNotifier {
  AuthViewModel(this._repository) {
    _authSubscription = _repository.userIds.listen(
      _onUser,
      onError: (_) => _setStatus(AuthStatus.error),
    );
  }
  final AuthRepository _repository;
  late final StreamSubscription<String?> _authSubscription;
  StreamSubscription<bool>? _adminSubscription;
  AuthStatus status = AuthStatus.loading;
  bool busy = false;
  String? error;
  bool _disposed = false;
  int _generation = 0;

  void _setStatus(AuthStatus value) {
    if (_disposed) return;
    status = value;
    notifyListeners();
  }

  void _onUser(String? uid) {
    final generation = ++_generation;
    _adminSubscription?.cancel();
    if (uid == null) {
      _setStatus(AuthStatus.signedOut);
      return;
    }
    _setStatus(AuthStatus.loading);
    _adminSubscription = _repository
        .watchAdmin(uid)
        .listen(
          (allowed) {
            if (generation == _generation) {
              _setStatus(allowed ? AuthStatus.authorized : AuthStatus.denied);
            }
          },
          onError: (_) {
            if (generation == _generation) _setStatus(AuthStatus.error);
          },
        );
  }

  Future<void> signIn(String email, String password) async {
    if (busy) return;
    if (email.trim().isEmpty || password.isEmpty) {
      error = 'Enter your email and password.';
      notifyListeners();
      return;
    }
    busy = true;
    error = null;
    notifyListeners();
    try {
      await _repository.signIn(email.trim(), password);
    } catch (_) {
      error = 'Sign-in failed. Check your credentials and connection.';
    } finally {
      if (!_disposed) {
        busy = false;
        notifyListeners();
      }
    }
  }

  Future<void> signOut() => _repository.signOut();
  @override
  void dispose() {
    _disposed = true;
    _authSubscription.cancel();
    _adminSubscription?.cancel();
    super.dispose();
  }
}

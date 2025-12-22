import 'package:flutter/foundation.dart';
import 'package:task_wise/features/auth/domain/repository/auth_repository.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthViewModel extends ChangeNotifier {
  final AuthRepository repository;

  AuthViewModel({required this.repository}) {
    checkAuthStatus();
  }

  AuthStatus _status = AuthStatus.unknown;

  AuthStatus get status => _status;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool get isAuthenticated => _status == AuthStatus.authenticated;

  Future<bool> login({required String email, required String password}) async {
    _setLoading(true);
    _errorMessage = null;

    final result = await repository.loginWithEmailPassword(
      email: email,
      password: password,
    );

    return result.fold(
      (failure) {
        _errorMessage = failure.message;
        _status = AuthStatus.unauthenticated;
        _setLoading(false);
        return false;
      },
      (user) {
        _status = AuthStatus.authenticated;
        _setLoading(false);
        return true;
      },
    );
  }

  Future<bool> signup({
    required email,
    required password,
    required firstName,
    required lastName,
    required phoneNumber,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    final result = await repository.signUpWithEmailPassword(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
    );

    return result.fold(
      (failure) {
        _errorMessage = failure.message;
        _setLoading(false);
        return false;
      },
      (success) {
        _setLoading(false);
        return true;
      },
    );
  }

  Future<void> checkAuthStatus() async {
    final result = await repository.currentUser();
    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _setLoading(false);
        _status = AuthStatus.unauthenticated;
      },
      (success) {
        _setLoading(false);
        _status = AuthStatus.authenticated;
      },
    );
  }

  Future<void> logout() async {}

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

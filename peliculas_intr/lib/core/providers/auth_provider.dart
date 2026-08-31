import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tp4_dap/core/services/auth_service.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(AuthService()),
);

class AuthState {
  final String? username;
  final bool isLoading;
  final String? errorMessage;

  const AuthState({this.username, this.isLoading = false, this.errorMessage});

  AuthState copyWith({String? username, bool? isLoading, String? errorMessage}) {
    return AuthState(
      username: username ?? this.username,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(const AuthState());

  Future<bool> login(String username, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final success = await _authService.login(username, password);
    state = state.copyWith(isLoading: false);

    if (success) {
      state = state.copyWith(username: username, errorMessage: null);
      return true;
    }

    return false;
  }

  Future<bool> register(String username, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final success = await _authService.register(username, password);
    state = state.copyWith(isLoading: false);
    if (!success) {
      state = state.copyWith(errorMessage: 'Este usuario ya esta registrado');
    }
    return success;
  }

  Future<List<String>> getRegisteredUsers() {
    return _authService.getRegisteredUsers();
  }

  void logout() {
    state = const AuthState();
  }
}


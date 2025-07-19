import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_app_riverpod/services/auth_service.dart';

class AuthState {
  final String? userEmail;
  final bool isLoading;
  final String? error;

  AuthState({
    this.userEmail,
    this.isLoading = false,
    this.error,
});

  AuthState copyWith({
    String? userEmail,
    bool? isLoading,
    String? error,
}) {
    return AuthState(
      userEmail: userEmail ?? this.userEmail,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(AuthState(isLoading: false));

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try{
      bool success = await _authService.login(email, password);
      if(success) {
        String? userEmail = await _authService.getUserEmail();
        state = state.copyWith(isLoading: false, userEmail: userEmail);
      } else {
        state = state.copyWith(isLoading: false, error: 'Invalid Credentials');
      }
    } catch(e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> signup(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try{
      bool success = await _authService.signup(email, password);
      if (success) {
        String? userEmail = await _authService.getUserEmail();
        state = state.copyWith(isLoading: false, userEmail: userEmail);
      } else {
        state = state.copyWith(isLoading: false, error: 'Signup Failed');
      }
    } catch(e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
  
  Future<void> logout() async {
    await _authService.logout();
    state = state.copyWith(isLoading: false, userEmail: null);
  }
  
  Future<void> checkAuthStatus() async {
    state = state.copyWith(isLoading: true);
    String? userEmail = await _authService.getUserEmail();
    state = state.copyWith(isLoading: false, error: userEmail);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(AuthService());
});

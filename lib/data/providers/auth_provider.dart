import 'package:flutter_riverpod/legacy.dart';
import '../models/user_profile.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const InitialAuthState());

  Future<bool> login(String phone, String otp) async {
    state = const InitialAuthState();
    await Future.delayed(const Duration(seconds: 1));
    
    if (otp == '123456') {
      state = AuthenticatedState(
        user: UserProfile(
          id: '1',
          name: 'Avinash',
          phone: phone,
          discom: 'UPPCL',
          accountType: 'Postpaid',
          isOnboardingComplete: false,
        ),
      );
      return true;
    }
    
    state = const UnauthenticatedAuthState();
    return false;
  }

  void logout() {
    state = const UnauthenticatedAuthState();
  }

  void completeOnboarding() {
    if (state is AuthenticatedState) {
      final user = (state as AuthenticatedState).user;
      state = AuthenticatedState(
        user: user.copyWith(isOnboardingComplete: true),
      );
    }
  }
}

abstract class AuthState {
  const AuthState();
}

class InitialAuthState extends AuthState {
  const InitialAuthState();
}

class UnauthenticatedAuthState extends AuthState {
  const UnauthenticatedAuthState();
}

class AuthenticatedState extends AuthState {
  final UserProfile user;
  const AuthenticatedState({required this.user});
}

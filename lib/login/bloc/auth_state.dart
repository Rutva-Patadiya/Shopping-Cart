import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final bool obscureText;
  final bool confirmPass;

  const AuthState({
    this.isLoading = false,
    this.obscureText = true,
    this.confirmPass = true,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? obscureText,
    required bool? confirmPass,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      obscureText: obscureText ?? this.obscureText,
      confirmPass: confirmPass ?? this.confirmPass,
    );
  }

  @override
  List<Object> get props => [isLoading, obscureText, confirmPass];
}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {}

class UserCreated extends AuthState {}

class LogOutUser extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});
}

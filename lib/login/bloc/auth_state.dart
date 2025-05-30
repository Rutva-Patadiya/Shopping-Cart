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

  //here just copied the state because,what if i need to change only the obscure text
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

class AuthInitial extends AuthState {}

class AuthInProgress extends AuthState {}

class AuthSuccess extends AuthState {
  final String? email;
  final String? name;
  final String? photoUrl;

  const AuthSuccess({
    required this.email,
    required this.name,
    required this.photoUrl,
  });
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});
}

class AuthRegistrationSuccess extends AuthState {}

class AuthLogOutSuccess extends AuthState {}

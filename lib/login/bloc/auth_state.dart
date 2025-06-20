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

  AuthInProgress withLoading() {
    return AuthInProgress();
  }
}

class AuthInitial extends AuthState {
  const AuthInitial({super.isLoading, super.obscureText, super.confirmPass});
}

class AuthInProgress extends AuthState {
  const AuthInProgress({super.isLoading, super.obscureText, super.confirmPass});
}

class AuthSuccess extends AuthState {
  final String? email;
  final String? name;
  final String? photoUrl;

  const AuthSuccess({
    super.isLoading,
    super.obscureText,
    super.confirmPass,
    required this.email,
    required this.name,
    required this.photoUrl,
  });
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({
    required this.message,
    super.isLoading,
    super.confirmPass,
    super.obscureText,
  });
}

class AuthRegistrationSuccess extends AuthState {
  const AuthRegistrationSuccess({
    super.isLoading,
    super.confirmPass,
    super.obscureText,
  });
}

class AuthLogOutSuccess extends AuthState {
  const AuthLogOutSuccess({
    super.isLoading,
    super.confirmPass,
    super.obscureText,
  });
}

class EmptyAuthState extends AuthState {
  const EmptyAuthState({super.isLoading, super.confirmPass, super.obscureText});
}

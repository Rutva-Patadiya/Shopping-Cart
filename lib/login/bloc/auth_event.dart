//declare one common class and extends , why because if we define the parameter for bloc builder then write only AUthSTate and there it will check the for different events

abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class SignUpStarted extends AuthEvent {
  final String email;
  final String password;

  SignUpStarted(this.email, this.password);
}

class LoginStarted extends AuthEvent {
  final String email;
  final String password;

  LoginStarted(this.email, this.password);

  List<Object> get props => [email, password];
}

//obscure text visibility
class PasswordVisibilityToggled extends AuthEvent {
 PasswordVisibilityToggled();

  List<Object> get props => [];
}

//textvisibility of confirm pass
class ConfirmPassVisibilityToggled extends AuthEvent {}

class LoggedOut extends AuthEvent {}

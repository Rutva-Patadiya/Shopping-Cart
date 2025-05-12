//declare one common class and extends , why because if we define the parameter for bloc builder then write only AUthSTate and there it will check the for different events

abstract class AuthEvent
{
}

class SignUpRequested extends AuthEvent
{
  final String email;
  final String password;
  SignUpRequested(this.email,this.password);
}

class LoginRequested extends AuthEvent
{
  final String email;
  final String password;
  LoginRequested(this.email, this.password);
  List<Object> get props => [email, password];
}

//obscure text visibility
class TextVisibility extends AuthEvent {
  TextVisibility();
  List<Object> get props => [];
}

//textvisibility of confirm pass
class ConfirmPass extends AuthEvent
{}



class LogOut extends AuthEvent
{

}

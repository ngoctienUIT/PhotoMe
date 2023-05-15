abstract class LoginScreenEvent {}

class Login extends LoginScreenEvent {
  String email;
  String password;

  Login(this.email, this.password);
}

class Init extends LoginScreenEvent {
  Init();
}

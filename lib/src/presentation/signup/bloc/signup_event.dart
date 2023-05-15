abstract class SignupScreenEvent {}

class Signup extends SignupScreenEvent {
  String email;
  String password;

  Signup(this.email, this.password);
}


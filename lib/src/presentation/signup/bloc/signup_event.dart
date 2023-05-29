abstract class SignupScreenEvent {}

class Signup extends SignupScreenEvent {
  String email;
  String password;
  String rePassword;
  String name;
  String gender;
  String phone;

  Signup(this.email, this.name, this.gender, this.phone, this.password, this.rePassword);
}

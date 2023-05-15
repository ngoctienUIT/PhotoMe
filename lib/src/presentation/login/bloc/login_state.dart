abstract class LoginState {}

class InitState extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginPending extends LoginState {}

class LoginError extends LoginState {
  String error;

  LoginError(this.error);
}

abstract class LoginState {}

class InitState extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  String? userID;

  LoginSuccess({this.userID});
}

class LoginPending extends LoginState {}

class LoginError extends LoginState {
  String error;

  LoginError(this.error);
}

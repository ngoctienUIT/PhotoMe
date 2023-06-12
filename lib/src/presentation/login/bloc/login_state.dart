import 'package:photo_me/src/domain/response/user/user_response.dart';

abstract class LoginState {}

class InitState extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  UserResponse user;
  String token;

  LoginSuccess(this.user, this.token);
}

class LoginPending extends LoginState {}

class LoginError extends LoginState {
  String error;

  LoginError(this.error);
}

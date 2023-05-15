abstract class SignupState {}

class InitState extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupPending extends SignupState {}

class SignupError extends SignupState {
  String error;

  SignupError(this.error);
}

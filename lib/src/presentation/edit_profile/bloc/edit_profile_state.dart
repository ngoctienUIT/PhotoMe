abstract class EditProfileState {}

class InitState extends EditProfileState {}

class UpdateSuccess extends EditProfileState {}

class UpdateLoading extends EditProfileState {}

class UpdateError extends EditProfileState {
  String error;

  UpdateError(this.error);
}

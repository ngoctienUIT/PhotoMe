import 'package:photo_me/src/domain/response/user/user_response.dart';

abstract class EditProfileState {}

class InitState extends EditProfileState {}

class UpdateSuccess extends EditProfileState {
  UserResponse user;

  UpdateSuccess(this.user);
}

class UpdateLoading extends EditProfileState {}

class UpdateError extends EditProfileState {
  String error;

  UpdateError(this.error);
}

class ChangeBirthDayState extends EditProfileState {}

class ChangeGenderState extends EditProfileState {}

class ChangeAvatarState extends EditProfileState {}

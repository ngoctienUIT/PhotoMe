import 'package:photo_me/src/data/model/user.dart';

abstract class EditProfileEvent {}

class UpdateProfileEvent extends EditProfileEvent {
  User user;

  UpdateProfileEvent(this.user);
}

class ChangeBirthDayEvent extends EditProfileEvent {}

class ChangeGenderEvent extends EditProfileEvent {}

class ChangeAvatarEvent extends EditProfileEvent {}

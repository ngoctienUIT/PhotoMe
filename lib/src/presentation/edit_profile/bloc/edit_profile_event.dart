import 'package:photo_me/src/data/model/user.dart';

abstract class EditProfileEvent {}

class UpdateProfileEvent extends EditProfileEvent {
  User user;

  UpdateProfileEvent(this.user);
}

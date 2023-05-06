abstract class OtherProfileEvent {}

class GetDataUser extends OtherProfileEvent {
  String id;

  GetDataUser(this.id);
}

class UpdateDataUser extends OtherProfileEvent {
  String id;

  UpdateDataUser(this.id);
}

class GetDataPost extends OtherProfileEvent {
  String id;

  GetDataPost(this.id);
}

class FollowUser extends OtherProfileEvent {
  String id;

  FollowUser(this.id);
}

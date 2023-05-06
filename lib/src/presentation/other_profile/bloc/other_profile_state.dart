import 'package:photo_me/src/domain/response/post/post_response.dart';
import 'package:photo_me/src/domain/response/user/user_response.dart';

abstract class OtherProfileState {}

class InitState extends OtherProfileState {}

class OtherProfileLoading extends OtherProfileState {}

class OtherProfileLoaded extends OtherProfileState {
  UserResponse user;

  OtherProfileLoaded(this.user);
}

class PostLoading extends OtherProfileState {}

class PostLoaded extends OtherProfileState {
  List<PostResponse> post;

  PostLoaded(this.post);
}

class FollowLoading extends OtherProfileState {}

class FollowSuccess extends OtherProfileState {}

class OtherProfileError extends OtherProfileState {
  String error;

  OtherProfileError(this.error);
}

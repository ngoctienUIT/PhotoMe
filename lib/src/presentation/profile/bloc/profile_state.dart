import 'package:photo_me/src/domain/response/post/post_response.dart';
import 'package:photo_me/src/domain/response/user/user_response.dart';

abstract class ProfileState {}

class InitState extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  UserResponse user;
  List<PostResponse> post;

  ProfileLoaded(this.user, this.post);
}

class ProfileError extends ProfileState {
  String error;

  ProfileError(this.error);
}

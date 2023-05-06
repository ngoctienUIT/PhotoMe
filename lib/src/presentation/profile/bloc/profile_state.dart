import 'package:photo_me/src/domain/response/post/post_response.dart';
import 'package:photo_me/src/domain/response/user/user_response.dart';

abstract class ProfileState {}

class InitState extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  UserResponse user;

  ProfileLoaded(this.user);
}

class ProfileError extends ProfileState {
  String error;

  ProfileError(this.error);
}

class PostLoading extends ProfileState {}

class PostLoaded extends ProfileState {
  List<PostResponse> post;

  PostLoaded(this.post);
}

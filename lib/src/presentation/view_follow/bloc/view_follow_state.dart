import '../../../domain/response/user/user_response.dart';

abstract class ViewFollowState {}

class InitState extends ViewFollowState {}

class ViewFollowLoading extends ViewFollowState {}

class ViewFollowLoaded extends ViewFollowState {
  List<UserResponse> follower;
  List<UserResponse> following;

  ViewFollowLoaded(this.follower, this.following);
}

class ViewFollowError extends ViewFollowState {
  String error;

  ViewFollowError(this.error);
}

class FollowSuccess extends ViewFollowState {}

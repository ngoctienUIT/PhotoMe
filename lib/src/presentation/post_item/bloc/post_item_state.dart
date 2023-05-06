abstract class PostItemState {}

class InitState extends PostItemState {}

class LikeSuccess extends PostItemState {}

class LikeLoading extends PostItemState {}

class ErrorState extends PostItemState {
  String error;

  ErrorState(this.error);
}

class FollowLoading extends PostItemState {}

class FollowSuccess extends PostItemState {}

class DeleteSuccess extends PostItemState {}

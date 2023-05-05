abstract class PostItemEvent {}

class LikePostEvent extends PostItemEvent {
  String id;

  LikePostEvent(this.id);
}

class FollowUserEvent extends PostItemEvent {
  String id;

  FollowUserEvent(this.id);
}

class DeletePostEvent extends PostItemEvent {
  String id;

  DeletePostEvent(this.id);
}

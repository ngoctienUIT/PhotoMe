abstract class ViewFollowEvent {}

class FetchData extends ViewFollowEvent {}

class FollowEvent extends ViewFollowEvent {
  String id;

  FollowEvent(this.id);
}

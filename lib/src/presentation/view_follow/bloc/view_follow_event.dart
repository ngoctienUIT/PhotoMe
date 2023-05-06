abstract class ViewFollowEvent {}

class FetchData extends ViewFollowEvent {
  String id;

  FetchData(this.id);
}

class FollowEvent extends ViewFollowEvent {
  String id;

  FollowEvent(this.id);
}

abstract class ViewPostEvent {}

class GetComment extends ViewPostEvent {
  String id;

  GetComment(this.id);
}

class GetPost extends ViewPostEvent {
  String id;

  GetPost(this.id);
}

class CommentPost extends ViewPostEvent {
  String id;
  String comment;

  CommentPost(this.id, this.comment);
}

class WriteComment extends ViewPostEvent {
  bool check;

  WriteComment(this.check);
}

class LikeComment extends ViewPostEvent {
  String id;

  LikeComment(this.id);
}

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

class ReplyComment extends ViewPostEvent {
  String idComment;
  String idPost;
  String comment;

  ReplyComment({
    required this.idPost,
    required this.idComment,
    required this.comment,
  });
}

class GetReplyComment extends ViewPostEvent {
  String id;

  GetReplyComment(this.id);
}

class ChangeCommentEvent extends ViewPostEvent {}

class WriteComment extends ViewPostEvent {
  bool check;

  WriteComment(this.check);
}

class LikeComment extends ViewPostEvent {
  String id;

  LikeComment(this.id);
}

class DeleteComment extends ViewPostEvent {
  String idComment;
  String idPost;

  DeleteComment(this.idPost, this.idComment);
}

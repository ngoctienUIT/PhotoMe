import 'package:photo_me/src/domain/response/post/post_response.dart';

import '../../../domain/response/comment/comment_response.dart';

abstract class ViewPostState {}

class InitState extends ViewPostState {}

class CommentLoading extends ViewPostState {}

class ChangeCommentState extends ViewPostState {}

class ErrorState extends ViewPostState {
  String error;

  ErrorState(this.error);
}

class CommentSuccess extends ViewPostState {
  List<CommentResponse> list;

  CommentSuccess(this.list);
}

class PostSuccess extends ViewPostState {
  PostResponse post;

  PostSuccess(this.post);
}

class GetReplySuccess extends ViewPostState {
  List<CommentResponse> list;
  String id;

  GetReplySuccess(this.id, this.list);
}

class WriteCommentState extends ViewPostState {
  bool check;

  WriteCommentState(this.check);
}

class LikeCommentLoading extends ViewPostState {
  String id;

  LikeCommentLoading(this.id);
}

class LikeCommentSuccess extends ViewPostState {
  String id;

  LikeCommentSuccess(this.id);
}

class DeleteCommentSuccess extends ViewPostState {
  String id;

  DeleteCommentSuccess(this.id);
}

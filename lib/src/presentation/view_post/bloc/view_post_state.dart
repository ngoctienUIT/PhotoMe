import 'package:photo_me/src/domain/response/post/post_response.dart';

import '../../../domain/response/comment/comment_response.dart';

abstract class ViewPostState {}

class InitState extends ViewPostState {}

class CommentLoading extends ViewPostState {}

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

class WriteCommentState extends ViewPostState {
  bool check;

  WriteCommentState(this.check);
}

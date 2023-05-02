abstract class NewPostState {}

class InitState extends NewPostState {}

class NewPostLoading extends NewPostState {}

class NewPostSuccess extends NewPostState {}

class NewPostError extends NewPostState {
  String error;

  NewPostError(this.error);
}

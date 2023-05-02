import '../../../domain/response/post/post_response.dart';

abstract class HomeState {}

class InitState extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  List<PostResponse> post;

  HomeLoaded(this.post);
}

class HomeError extends HomeState {
  String error;

  HomeError(this.error);
}

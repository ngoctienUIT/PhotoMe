import 'package:photo_me/src/data/model/user.dart';
import 'package:photo_me/src/domain/response/user/user_response.dart';

import '../../../domain/response/post/post_response.dart';

abstract class SearchState {}

class InitState extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  List<UserResponse> users;

  SearchSuccess(this.users);
}

class SearchError extends SearchState {
  String error;

  SearchError(this.error);
}

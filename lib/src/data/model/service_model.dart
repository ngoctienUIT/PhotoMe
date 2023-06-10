import 'package:photo_me/src/domain/response/post/post_response.dart';
import 'package:photo_me/src/domain/response/user/user_response.dart';

class ServiceModel {
  String token;
  UserResponse? user;
  List<PostResponse> posts;

  ServiceModel({this.posts = const [], this.user, this.token = ""});

  ServiceModel copyWith({
    List<PostResponse>? posts,
    UserResponse? user,
    String? token,
  }) {
    return ServiceModel(
      posts: posts ?? this.posts,
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }
}

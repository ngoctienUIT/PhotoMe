import 'package:photo_me/src/domain/response/post/post_response.dart';

class ServiceModel {
  List<PostResponse> posts;

  ServiceModel({this.posts = const []});

  ServiceModel copyWith({List<PostResponse>? posts}) {
    return ServiceModel(posts: posts ?? this.posts);
  }
}

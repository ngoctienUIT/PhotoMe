import 'package:json_annotation/json_annotation.dart';

import '../user/user_response.dart';

part 'comment_response.g.dart';

@JsonSerializable()
class CommentResponse {
  @JsonKey(name: "_id")
  final String id;

  @JsonKey(name: "id_Post")
  final String? idPost;

  @JsonKey(name: "user")
  final UserResponse user;

  @JsonKey(name: "comment")
  final String comment;

  @JsonKey(name: "liked")
  final List<String> liked;

  @JsonKey(name: "reply")
  final List<String> reply;

  @JsonKey(name: "registration_data")
  final String registration;

  CommentResponse(this.id, this.idPost, this.user, this.comment, this.liked,
      this.reply, this.registration);

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommentResponseToJson(this);
}

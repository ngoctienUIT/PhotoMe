import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../user/user_response.dart';

part 'post_response.g.dart';

@JsonSerializable()
class PostResponse extends Equatable {
  @JsonKey(name: "_id")
  final String id;

  @JsonKey(name: "id_User")
  final String? idUser;

  @JsonKey(name: "user")
  final UserResponse user;

  @JsonKey(name: "description")
  final String description;

  @JsonKey(name: "photo")
  final List<String> photo;

  @JsonKey(name: "liked")
  final List<String> liked;

  @JsonKey(name: "comment")
  final List<String> comment;

  @JsonKey(name: "registration_data")
  final String registration;

  const PostResponse(
    this.id,
    this.idUser,
    this.description,
    this.photo,
    this.liked,
    this.comment,
    this.user,
    this.registration,
  );

  factory PostResponse.fromJson(Map<String, dynamic> json) =>
      _$PostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);

  @override
  List<Object?> get props => [description, photo, liked, comment, id, user];
}

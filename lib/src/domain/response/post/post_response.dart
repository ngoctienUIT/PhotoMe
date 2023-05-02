import 'package:json_annotation/json_annotation.dart';

part 'post_response.g.dart';

@JsonSerializable()
class PostResponse {
  @JsonKey(name: "_id")
  final String id;

  @JsonKey(name: "id_User")
  final String idUser;

  @JsonKey(name: "description")
  final String description;

  @JsonKey(name: "photo")
  final List<String> photo;

  @JsonKey(name: "liked")
  final List<String> liked;

  @JsonKey(name: "comment")
  final List<String> comment;

  PostResponse(
    this.id,
    this.idUser,
    this.description,
    this.photo,
    this.liked,
    this.comment,
  );

  factory PostResponse.fromJson(Map<String, dynamic> json) =>
      _$PostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: "_id")
  final String id;

  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "email")
  final String email;

  @JsonKey(name: "phoneNumber")
  final String phoneNumber;

  @JsonKey(name: "password")
  final String? password;

  @JsonKey(name: "gender")
  final String? gender;

  @JsonKey(name: "birthday")
  final String? birthday;

  @JsonKey(name: "avatar")
  final String avatar;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "job")
  final String? job;

  @JsonKey(name: "post")
  final List<String>? post;

  @JsonKey(name: "follower")
  final List<String>? follower;

  @JsonKey(name: "following")
  final List<String>? following;

  UserResponse(
      this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.password,
      this.gender,
      this.birthday,
      this.avatar,
      this.description,
      this.job,
      this.post,
      this.follower,
      this.following);

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

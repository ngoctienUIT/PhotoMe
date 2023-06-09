import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse extends Equatable {
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
  final String? description;

  @JsonKey(name: "job")
  final String? job;

  @JsonKey(name: "post")
  final List<String>? post;

  @JsonKey(name: "follower")
  final List<String> follower;

  @JsonKey(name: "following")
  final List<String> following;

  @JsonKey(name: "notifications")
  final List<String>? notifications;

  @JsonKey(name: "device_token")
  final String? deviceToken;

  const UserResponse(
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
    this.following,
    this.notifications,
    this.deviceToken,
  );

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  UserResponse copyWith({
    String? name,
    String? job,
    String? description,
    String? avatar,
    String? birthday,
    String? password,
    String? gender,
  }) {
    return UserResponse(
      id,
      name ?? this.name,
      email,
      phoneNumber,
      password ?? this.password,
      gender ?? this.gender,
      birthday ?? this.birthday,
      avatar ?? this.avatar,
      description ?? this.description,
      job ?? this.job,
      post,
      follower,
      following,
      notifications,
      deviceToken,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, avatar, following, follower, description, job, birthday];
}

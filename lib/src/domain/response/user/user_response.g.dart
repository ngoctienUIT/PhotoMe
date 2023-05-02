// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      json['_id'] as String,
      json['name'] as String,
      json['email'] as String,
      json['phoneNumber'] as String,
      json['password'] as String,
      json['gender'] as String,
      json['birthday'] as String,
      json['avatar'] as String,
      json['description'] as String?,
      json['job'] as String,
      (json['post'] as List<dynamic>).map((e) => e as String).toList(),
      (json['follower'] as List<dynamic>).map((e) => e as String).toList(),
      (json['following'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'gender': instance.gender,
      'birthday': instance.birthday,
      'avatar': instance.avatar,
      'description': instance.description,
      'job': instance.job,
      'post': instance.post,
      'follower': instance.follower,
      'following': instance.following,
    };

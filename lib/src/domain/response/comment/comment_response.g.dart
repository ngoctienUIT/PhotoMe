// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentResponse _$CommentResponseFromJson(Map<String, dynamic> json) =>
    CommentResponse(
      json['_id'] as String,
      json['id_Post'] as String?,
      UserResponse.fromJson(json['user'] as Map<String, dynamic>),
      json['comment'] as String,
      (json['liked'] as List<dynamic>).map((e) => e as String).toList(),
      (json['reply'] as List<dynamic>).map((e) => e as String).toList(),
      json['registration_data'] as String,
    );

Map<String, dynamic> _$CommentResponseToJson(CommentResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'id_Post': instance.idPost,
      'user': instance.user,
      'comment': instance.comment,
      'liked': instance.liked,
      'reply': instance.reply,
      'registration_data': instance.registration,
    };

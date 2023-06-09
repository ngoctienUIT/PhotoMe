// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationHmResponse _$NotificationHmResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationHmResponse(
      json['_id'] as String,
      json['id_FromUser'] as String,
      json['id_ToUser'] as String,
      json['text'] as String,
      json['isRead'] as bool,
      json['time'] as String,
      UserResponse.fromJson(json['to_user'] as Map<String, dynamic>),
      json['to_Post'] as String?,
      json['post'] == null
          ? null
          : PostResponse.fromJson(json['post'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationHmResponseToJson(
        NotificationHmResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'id_FromUser': instance.idFromUser,
      'id_ToUser': instance.idToUser,
      'text': instance.text,
      'isRead': instance.isRead,
      'time': instance.time,
      'to_Post': instance.toPost,
      'to_user': instance.toUser,
      'post': instance.post,
    };

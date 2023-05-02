// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostResponse _$PostResponseFromJson(Map<String, dynamic> json) => PostResponse(
      json['_id'] as String,
      json['id_User'] as String,
      json['description'] as String,
      (json['photo'] as List<dynamic>).map((e) => e as String).toList(),
      (json['liked'] as List<dynamic>).map((e) => e as String).toList(),
      (json['comment'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PostResponseToJson(PostResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'id_User': instance.idUser,
      'description': instance.description,
      'photo': instance.photo,
      'liked': instance.liked,
      'comment': instance.comment,
    };

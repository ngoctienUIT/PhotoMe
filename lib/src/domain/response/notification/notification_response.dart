import 'package:json_annotation/json_annotation.dart';
import 'package:photo_me/src/domain/response/user/user_response.dart';

part 'notification_response.g.dart';

@JsonSerializable()
class NotificationHmResponse {
  @JsonKey(name: "_id")
  final String id;

  @JsonKey(name: "id_FromUser")
  final String idFromUser;

  @JsonKey(name: "id_ToUser")
  final String idToUser;

  @JsonKey(name: "text")
  final String text;

  @JsonKey(name: "isRead")
  final bool isRead;

  @JsonKey(name: "time")
  final String time;

  @JsonKey(name: "to_user")
  final UserResponse toUser;

  const NotificationHmResponse(this.id, this.idFromUser, this.idToUser,
      this.text, this.isRead, this.time, this.toUser);

  factory NotificationHmResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationHmResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationHmResponseToJson(this);

// @override
// // TODO: implement props
// List<Object?> get props => throw UnimplementedError();
}

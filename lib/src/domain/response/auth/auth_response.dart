import 'package:json_annotation/json_annotation.dart';
import 'package:photo_me/src/domain/response/user/user_response.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  @JsonKey(name: "token")
  final String token;

  @JsonKey(name: "user")
  final UserResponse user;

  AuthResponse(this.token, this.user);

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
import 'package:photo_me/src/domain/response/auth/SubAuth.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  @JsonKey(name: "token")
  final String token;

  @JsonKey(name: "user")
  final SubAuth user;

  AuthResponse(this.token, this.user);

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'SubAuth.g.dart';

@JsonSerializable()
class SubAuth {
  @JsonKey(name: "id")
  final String id;


  factory SubAuth.fromJson(Map<String, dynamic> json) =>
      _$SubAuthFromJson(json);

  SubAuth(this.id);

  Map<String, dynamic> toJson() => _$SubAuthToJson(this);
}
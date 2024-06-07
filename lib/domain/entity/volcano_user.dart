import 'package:freezed_annotation/freezed_annotation.dart';

// part 'volcano_user.freezed.dart';
// part 'volcano_user.g.dart';

// @freezed
// class VolcanoUser with _$VolcanoUser {
//     const factory VolcanoUser({
//         @JsonKey(name: "user_id")
//         String? userId,
//         @JsonKey(name: "username")
//         String? username,
//         @JsonKey(name: "email")
//         String? email,
//         @JsonKey(name: "created_at")
//         DateTime? createdAt,
//         @JsonKey(name: "hashed_password")
//         String? hashedPassword,
//         @JsonKey(name: "id")
//         int? id,
//         @JsonKey(name: "icon")
//         String? icon,
//         @JsonKey(name: "updated_at")
//         DateTime? updatedAt,
//     }) = _VolcanoUser;

//     factory VolcanoUser.fromJson(Map<String, dynamic> json) => _$VolcanoUserFromJson(json);
// }

class VolcanoUser {
  VolcanoUser({
    this.id,
    this.userId,
    this.username,
    this.hashedPassword,
    this.email,
    this.icon,
    this.createdAt,
    this.updatedAt,
  });
  final int? id;
  final String? userId;
  final String? username;
  final String? hashedPassword;
  final String? email;
  final String? icon;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
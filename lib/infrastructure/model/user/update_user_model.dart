import 'dart:convert';

class UpdateUserModel {
  UpdateUserModel({
    this.email,
    this.username,
    this.icon,
  });

  factory UpdateUserModel.fromRawJson(String str) =>
      UpdateUserModel.fromJson(json.decode(str));

  factory UpdateUserModel.fromJson(Map<String, dynamic> json) =>
      UpdateUserModel(
        email: json['email'],
        username: json['username'],
        icon: json['icon'],
      );
  final String? email;
  final String? username;
  final dynamic icon;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'email': email,
        'username': username,
        'icon': icon,
      };
}

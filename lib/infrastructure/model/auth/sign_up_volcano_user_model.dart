import 'dart:convert';

// NOTE this file is for sending this model as a Body to back-end
class SignUpVolcanoUserModel {
  SignUpVolcanoUserModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  factory SignUpVolcanoUserModel.fromRawJson(String str) =>
      SignUpVolcanoUserModel.fromJson(json.decode(str));

  factory SignUpVolcanoUserModel.fromJson(Map<String, dynamic> json) =>
      SignUpVolcanoUserModel(
        email: json['email'],
        password: json['password'],
        confirmPassword: json['confirm_password'],
      );
  final String email;
  final String password;
  final String confirmPassword;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
      };
}

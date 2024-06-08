import 'dart:convert';

class AuthError {
  AuthError({this.statusCode, this.message});
  final int? statusCode;
  final AuthErrorMessage? message;
}

class AuthErrorMessage {
  AuthErrorMessage({
    this.detail,
  });

  factory AuthErrorMessage.fromRawJson(String str) =>
      AuthErrorMessage.fromJson(json.decode(str));

  factory AuthErrorMessage.fromJson(Map<String, dynamic> json) =>
      AuthErrorMessage(
        detail: json['detail'],
      );
  final String? detail;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'detail': detail,
      };
}

import 'dart:convert';
class AuthError {
  final int? statusCode;
  final AuthErrorMessage? message;

  AuthError({this.statusCode, this.message});
}



class AuthErrorMessage {
    final String? detail;

    AuthErrorMessage({
        this.detail,
    });

    factory AuthErrorMessage.fromRawJson(String str) => AuthErrorMessage.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AuthErrorMessage.fromJson(Map<String, dynamic> json) => AuthErrorMessage(
        detail: json["detail"],
    );

    Map<String, dynamic> toJson() => {
        "detail": detail,
    };
}

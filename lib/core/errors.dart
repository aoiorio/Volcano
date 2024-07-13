import 'dart:convert';

class BackEndError {
  BackEndError({this.statusCode, this.message});
  final int? statusCode;
  final BackEndErrorMessage? message;
}

class BackEndErrorMessage {
  BackEndErrorMessage({
    this.detail,
  });

  factory BackEndErrorMessage.fromRawJson(String str) =>
      BackEndErrorMessage.fromJson(json.decode(str));

  factory BackEndErrorMessage.fromJson(Map<String, dynamic> json) =>
      BackEndErrorMessage(
        detail: json['detail'] ?? 'Something went wrong',
      );
  final String? detail;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'detail': detail,
      };
}

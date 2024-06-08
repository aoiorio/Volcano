import 'dart:convert';

import 'package:volcano/domain/entity/token.dart';

class TokenDTO extends Token {
  TokenDTO({
    super.accessToken,
    super.tokenType,
  });

  factory TokenDTO.fromJson(Map<String, dynamic> json) => TokenDTO(
        accessToken: json['access_token'],
        tokenType: json['token_type'],
      );

  factory TokenDTO.fromRawJson(String str) =>
      TokenDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'token_type': tokenType,
      };
}

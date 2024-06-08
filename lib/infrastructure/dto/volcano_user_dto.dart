import 'dart:convert';

import 'package:volcano/domain/entity/volcano_user.dart';

class VolcanoUserDTO extends VolcanoUser{

    VolcanoUserDTO({
        super.userId,
        super.username,
        super.email,
        super.createdAt,
        super.hashedPassword,
        super.id,
        super.icon,
        super.updatedAt,
    });

    factory VolcanoUserDTO.fromJson(Map<String, dynamic> json) => VolcanoUserDTO(
        userId: json['user_id'],
        username: json['username'],
        email: json['email'],
        createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
        hashedPassword: json['hashed_password'],
        id: json['id'],
        icon: json['icon'],
        updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at']),
    );

    factory VolcanoUserDTO.fromRawJson(String str) => VolcanoUserDTO.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    Map<String, dynamic> toJson() => {
        'user_id': userId,
        'username': username,
        'email': email,
        'created_at': createdAt?.toIso8601String(),
        'hashed_password': hashedPassword,
        'id': id,
        'icon': icon,
        'updated_at': updatedAt?.toIso8601String(),
    };
}

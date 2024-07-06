import 'dart:convert';

import 'package:volcano/domain/entity/tyoe_color_object.dart';

class TypeColorObjectDTO extends TypeColorObject {
  TypeColorObjectDTO({
    super.colorId,
    super.type,
    super.endColorCode,
    super.createdAt,
    super.startColorCode,
    super.id,
    super.updatedAt,
  });

  factory TypeColorObjectDTO.fromJson(Map<String, dynamic> json) =>
      TypeColorObjectDTO(
        colorId: json['color_id'],
        type: json['type'],
        endColorCode: json['end_color_code'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        startColorCode: json['start_color_code'],
        id: json['id'],
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
      );

  factory TypeColorObjectDTO.fromRawJson(String str) =>
      TypeColorObjectDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'color_id': colorId,
        'type': type,
        'end_color_code': endColorCode,
        'created_at': createdAt?.toIso8601String(),
        'start_color_code': startColorCode,
        'id': id,
        'updated_at': updatedAt?.toIso8601String(),
      };
}

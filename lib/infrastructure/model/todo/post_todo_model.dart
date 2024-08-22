import 'dart:convert';

class PostTodoModel {
  PostTodoModel({
    this.title,
    this.description,
    this.period,
    this.priority,
    this.type,
  });

  factory PostTodoModel.fromJson(Map<String, dynamic> json) => PostTodoModel(
        title: json['title'],
        description: json['description'],
        period: json['period'] == null ? null : DateTime.parse(json['period']),
        priority: json['priority'],
        type: json['type'],
      );

  factory PostTodoModel.fromRawJson(String str) =>
      PostTodoModel.fromJson(json.decode(str));
  final String? title;
  final String? description;
  final DateTime? period;
  final int? priority;
  final String? type;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'period': period?.toIso8601String(),
        'priority': priority,
        'type': type,
      };
}

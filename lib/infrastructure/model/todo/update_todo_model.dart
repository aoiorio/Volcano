import 'dart:convert';

class UpdateTodoModel {

    UpdateTodoModel({
        this.title,
        this.description,
        this.period,
        this.type,
        this.priority,
        this.isCompleted,
        this.audioUrl,
    });

    factory UpdateTodoModel.fromJson(Map<String, dynamic> json) => UpdateTodoModel(
        title: json['title'],
        description: json['description'],
        period: json['period'] == null ? null : DateTime.parse(json['period']),
        type: json['type'],
        priority: json['priority'],
        isCompleted: json['is_completed'],
        audioUrl: json['audio_url'],
    );

    factory UpdateTodoModel.fromRawJson(String str) => UpdateTodoModel.fromJson(json.decode(str));
    final String? title;
    final String? description;
    final DateTime? period;
    final String? type;
    final int? priority;
    final bool? isCompleted;
    final String? audioUrl;

    String toRawJson() => json.encode(toJson());

    Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'period': period?.toIso8601String(),
        'type': type,
        'priority': priority,
        'is_completed': isCompleted,
        'audio_url': audioUrl,
    };
}

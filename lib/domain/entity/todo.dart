class Todo {
  Todo({
    this.id,
    this.todoId,
    this.title,
    this.description,
    this.period,
    this.priority,
    this.type,
    this.userId,
    this.audioUrl,
    this.isCompleted,
    this.createdAt,
    this.updatedAt,
  });
  final int? id;
  final String? todoId;
  final String? title;
  final String? description;
  final DateTime? period;
  final int? priority;
  final String? type;
  final String? userId;
  final String? audioUrl;
  final bool? isCompleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}

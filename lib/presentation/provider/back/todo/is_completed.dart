import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/domain/entity/todo.dart';

part 'is_completed.g.dart';

@riverpod
class IsCompleted extends _$IsCompleted {
  final isCompletedList = <Map<String, bool>>[];

  @override
  bool build(List<Todo> todoList, String todoId) {
    final todoIdList = <String>[];

    for (final todo in todoList) {
      if (todoIdList.contains(todo.todoId)) {
        continue;
      }
      isCompletedList.add({todo.todoId ?? '': todo.isCompleted ?? false});
      todoIdList.add(todo.todoId ?? '');
    }

    final index =
        isCompletedList.indexWhere((element) => element.containsKey(todoId));

    return isCompletedList[index][todoId] ?? false;
  }

  void updateIsCompleted({
    required String todoId,
    required bool updatedBool,
  }) {
    final index =
        isCompletedList.indexWhere((element) => element.containsKey(todoId));
    isCompletedList[index][todoId] = updatedBool;
    state = updatedBool;
  }
}

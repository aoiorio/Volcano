import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/domain/entity/todo.dart';

part 'is_playing_voice_of_todo.g.dart';

@riverpod
class IsPlayingVoiceOfTodo extends _$IsPlayingVoiceOfTodo {
  final isPlayingVoiceList = <Map<String, bool>>[];

  @override
  bool build(List<Todo> todoList, String todoId) {
    final todoIdList = <String>[];
    for (final todo in todoList) {
      if (todoIdList.contains(todo.todoId)) {
        continue;
      }
      isPlayingVoiceList.add({todo.todoId ?? '': false});
      todoIdList.add(todo.todoId ?? '');
    }

    final index =
        isPlayingVoiceList.indexWhere((element) => element.containsKey(todoId));

    return isPlayingVoiceList[index][todoId] ?? false;
  }

  void updateIsPlaying({
    required String todoId,
    required bool updatedBool,
  }) {
    final index =
        isPlayingVoiceList.indexWhere((element) => element.containsKey(todoId));
    isPlayingVoiceList[index][todoId] = updatedBool;
    state = updatedBool;
  }
}

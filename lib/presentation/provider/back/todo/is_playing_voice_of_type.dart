import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/presentation/provider/back/todo/controller/todo_controller.dart';

part 'is_playing_voice_of_type.g.dart';

@riverpod
class IsPlayingVoiceOfType extends _$IsPlayingVoiceOfType {
  final isPlayingMusicList = <Map<String, bool>>[];

  @override
  bool build(String type) {
    // TODO get the value of todos as an argument
    final todos = ref.watch(todoControllerProvider);
    final typeList = <String>[];
    if (todos.isRight()) {
      todos.getRight().fold(() => null, (readTodoList) {
        for (final readTodo in readTodoList) {
          for (final todo in readTodo.values!) {
            // NOTE if there's the same type in typeList, skip this process
            if (typeList.contains(todo.type)) {
              continue;
            }
            isPlayingMusicList.add({todo.type ?? '' : false});
            typeList.add(readTodo.type ?? '');
          }
        }
      });
    }
    final index =
        isPlayingMusicList.indexWhere((element) => element.containsKey(type));

    return isPlayingMusicList[index][type] ?? false;
  }

  void updateIsPlaying({
    required String type,
    required bool updatedBool,
  }) {
    final index =
        isPlayingMusicList.indexWhere((element) => element.containsKey(type));
    isPlayingMusicList[index][type] = updatedBool;
    state = updatedBool;
  }
}

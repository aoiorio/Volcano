import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/presentation/provider/back/todo/controller/todo_controller.dart';

part 'play_list.g.dart';

// NOTE this class is for adding audio urls with correspondent types!
@riverpod
class PlayList extends _$PlayList {
  @override
  List<String> build(String type) {
    final userTodo = ref.watch(todoControllerProvider);
    final typeList = <String>[];
    final result = <Map<String, List<String>>>[];

    if (userTodo.isRight()) {
      userTodo.getRight().fold(() => null, (readTodoList) {
        for (final readTodo in readTodoList) {
          for (final todo in readTodo.values!) {
            if (typeList.contains(todo.type) && todo.audioUrl != null) {
              // ! DO NOT USE "type", use todo.type because it will cause error
              final index = result
                  .indexWhere((element) => element.containsKey(todo.type));

              // NOTE I want to limit the length of list
              if (result[index][todo.type]!.length >= 3) {
                continue;
              }
              result[index][todo.type]!.add(todo.audioUrl ?? '');
              continue;
            }
            result.add({
              todo.type ?? '': [todo.audioUrl ?? ''],
            });
            typeList.add(todo.type ?? '');
          }
        }
      });
    }
    final index = result.indexWhere((element) => element.containsKey(type));
    return result[index][type] ?? [];
  }
}

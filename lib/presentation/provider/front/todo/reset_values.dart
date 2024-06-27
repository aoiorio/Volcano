import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/presentation/provider/back/todo/controller/post_todo_controller.dart';

part 'reset_values.g.dart';

@riverpod
class ResetValues extends _$ResetValues {
  @override
  String build() {
    return '';
  }

  void resetValues() {
    final postTodoNotifier = ref.read(postTodoControllerProvider.notifier);
    postTodoNotifier.titleTextController.clear();
    postTodoNotifier.descriptionTextController.clear();
    postTodoNotifier.typeTextController.clear();
    postTodoNotifier.priority = 1;
    ref.read(todoPeriodProvider.notifier).state = DateTime.now().toLocal();
  }
}

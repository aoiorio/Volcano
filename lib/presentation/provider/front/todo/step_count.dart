import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'step_count.g.dart';

@riverpod
class AddTodoStepCount extends _$AddTodoStepCount {
  @override
  int build() {
    return 0;
  }

  void increment() {
    state++;
  }

  void decrement() {
    state--;
  }
}

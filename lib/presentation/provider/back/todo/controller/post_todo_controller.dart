import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/infrastructure/dto/todo.dart';
import 'package:volcano/presentation/component/global/custom_toast.dart';
import 'package:volcano/presentation/provider/back/auth/shared_preference.dart';
import 'package:volcano/presentation/provider/back/todo/controller/todo_controller.dart';
import 'package:volcano/presentation/provider/back/todo/providers.dart';
import 'package:volcano/presentation/provider/front/todo/record_voice/record_voice_with_wave.dart';
import 'package:volcano/presentation/provider/front/todo/reset_values.dart';
import 'package:volcano/presentation/provider/global/progress_controller.dart';

part 'post_todo_controller.g.dart';

final todoPeriodProvider =
    StateProvider<DateTime>((ref) => DateTime.now().toLocal());

// NOTE you must change keepAlive to change to save TextEditingController texts such as titleTextController.text and so on
@Riverpod(keepAlive: true)
class PostTodoController extends _$PostTodoController {
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  TextEditingController typeTextController = TextEditingController();
  int priority = 1;

  @override
  TodoDTO build() {
    return TodoDTO();
  }

  void postTodo(FToast toast, BuildContext context) {
    final path = ref.watch(recordVoiceWithWaveControllerProvider.notifier).path;
    final period = ref.watch(todoPeriodProvider);

    if (path!.isEmpty) {
      debugPrint('The file path is empty');
      showToastMessage(
        toast,
        '😵‍💫 Something went wrong',
        ToastWidgetKind.error,
      );
      return;
    }
    if (titleTextController.text.isEmpty || typeTextController.text.isEmpty) {
      showToastMessage(
        toast,
        '😵‍💫 Fill Title and Type',
        ToastWidgetKind.error,
      );
      return;
    }
    final token = ref.read(authSharedPreferenceProvider);
    ref.read(progressControllerProvider.notifier).executeWithProgress(
          ref
              .read(todoUseCaseProvider)
              .executePostTodo(
                token: token,
                title: titleTextController.text,
                description: descriptionTextController.text,
                type: typeTextController.text,
                period: period.toLocal(),
                priority: priority,
                audio: File(path),
              )
              .then((value) {
            // NOTE delete the path
            File(path).delete();
            ref.read(todoControllerProvider.notifier).executeLocalAddTodo(
                  TodoDTO(
                    title: titleTextController.text,
                    description: descriptionTextController.text,
                    type: typeTextController.text,
                    period: period.toLocal(),
                    priority: priority,
                  ),
                );

            // NOTE delete all of data
            ref.read(recordVoiceWithWaveControllerProvider.notifier).path = '';
            showToastMessage(toast, '💡 TODO Added', ToastWidgetKind.success);
            ref.read(resetValuesProvider.notifier).resetValues();
            return value;
          }),
        );
    context.pop();
  }

  void postTodoFromText(FToast toast, BuildContext context) {
    final period = ref.watch(todoPeriodProvider);
    if (titleTextController.text.isEmpty ||
        typeTextController.text.isEmpty ||
        titleTextController.text.length <= 3 ||
        typeTextController.text.length <= 3) {
      showToastMessage(
        toast,
        '😵‍💫 Title And Type Must Have\nAt Least 3 Characters',
        ToastWidgetKind.error,
      );
      return;
    }
    final token = ref.read(authSharedPreferenceProvider);
    ref.read(progressControllerProvider.notifier).executeWithProgress(
          ref
              .read(todoUseCaseProvider)
              .executePostTodoFromText(
                token: token,
                title: titleTextController.text,
                description: descriptionTextController.text,
                type: typeTextController.text,
                period: period.toLocal(),
                priority: priority,
              )
              .then((value) {
            // NOTE delete all of data
            ref.read(recordVoiceWithWaveControllerProvider.notifier).path = '';
            showToastMessage(toast, '💡 TODO Added', ToastWidgetKind.success);
            // NOTE clear the values
            ref.read(resetValuesProvider.notifier).resetValues();
            return value;
          }),
        );
    ref.read(todoControllerProvider.notifier).executeLocalAddTodo(
          TodoDTO(
            title: titleTextController.text,
            description: descriptionTextController.text,
            type: typeTextController.text,
            period: period.toLocal(),
            priority: priority,
          ),
        );
    context.pop();
  }

  // TODO create post without voice method here
}

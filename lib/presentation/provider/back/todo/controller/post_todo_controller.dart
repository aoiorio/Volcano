import 'dart:io';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/infrastructure/dto/todo.dart';
import 'package:volcano/presentation/provider/back/auth/shared_preference.dart';
import 'package:volcano/presentation/provider/back/todo/providers.dart';
import 'package:volcano/presentation/provider/front/todo/record_voice/record_voice_controller.dart';

part 'post_todo_controller.g.dart';

@riverpod
class PostTodoController extends _$PostTodoController {
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  TextEditingController typeTextController = TextEditingController();
  DateTime period = DateTime.now();
  int priority = 1;

  @override
  TodoDTO build() {
    return TodoDTO();
  }

  void postTodo() {
    final path = ref.read(recordVoiceControllerProvider);
    if (path!.isEmpty) {
      return;
    }
    final token = ref.read(authSharedPreferenceProvider);
    ref
        .read(todoUseCaseProvider)
        .executePostTodo(
          token: token,
          title: titleTextController.text,
          description: descriptionTextController.text,
          type: typeTextController.text,
          period: period,
          priority: priority,
          audio: File(path),
        )
        .then((value) {
      // NOTE delete the path
      File(path).delete();
    });
  }
}

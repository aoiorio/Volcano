// DONE create the dialog of choosing delete todo or updating todo here
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:volcano/infrastructure/dto/todo.dart';
import 'package:volcano/presentation/component/global/bounced_button.dart';
import 'package:volcano/presentation/component/global/confirm_dialog.dart';
import 'package:volcano/presentation/page/dialogs/update_todo_dialog.dart';
import 'package:volcano/presentation/provider/back/todo/controller/delete_todo_controller.dart';
import 'package:volcano/presentation/provider/back/todo/controller/todo_controller.dart';
import 'package:volcano/presentation/provider/back/todo/controller/update_todo_controller.dart';

class UpdateOrDeleteDialog extends ConsumerWidget {
  const UpdateOrDeleteDialog({
    super.key,
    required this.todo,
  });

  final TodoDTO todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toast = FToast();
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: 340,
      height: 34,
      margin: EdgeInsets.only(
        right: width >= 850 ? width * 0.3 : 30,
        left: width >= 850 ? width * 0.3 : 30,
        top: 210,
        bottom: 210,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [
            Color(0xffBEC1C2),
            Color(0xffC1C1C1),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: IconButton(
                  highlightColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              Gap(width >= 850 ? 40 : 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BouncedButton(
                    child: Container(
                      width: 130,
                      height: 210,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff615353),
                            Color(0xff8D8585),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 30,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '"DELETE"',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    onPress: () {
                      HapticFeedback.lightImpact();
                      showConfirmDialog(
                        context,
                        'Are you really \n thinking about DELETING TODO?',
                        () {
                          ref
                              .read(todoControllerProvider.notifier)
                              .executeLocalDeleteTodo(todo);
                          ref
                              .read(deleteTodoControllerProvider.notifier)
                              .executeDeleteTodo(
                                todoId: todo.todoId ?? '',
                                toast: toast,
                              );
                          context
                            ..pop()
                            ..pop();
                        },
                        () {
                          context.pop();
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  BouncedButton(
                    child: Container(
                      width: 130,
                      height: 210,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff74737B),
                            Color(0xff8D8585),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.draw, color: Colors.white, size: 30),
                          const SizedBox(height: 10),
                          Text(
                            '"UPDATE"',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    onPress: () {
                      context.pop();
                      final updateTodoControllerNotifier =
                          ref.read(updateTodoControllerProvider.notifier);
                      updateTodoControllerNotifier.titleTextController.text =
                          todo.title ?? '';
                      updateTodoControllerNotifier.descriptionTextController
                          .text = todo.description ?? '';
                      updateTodoControllerNotifier.audioUrlTextController.text =
                          todo.audioUrl ?? '';
                      updateTodoControllerNotifier.priority =
                          todo.priority ?? 3;
                      updateTodoControllerNotifier.typeTextController.text =
                          todo.type ?? '';
                      updateTodoControllerNotifier
                        ..isCompleted = todo.isCompleted ?? false
                        ..period = todo.period ?? DateTime.now();
                      ref.read(updateTodoPeriodProvider.notifier).state =
                          todo.period ?? DateTime.now();
                      showUpdateTodoDialog(context, todo);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showUpdateOrDeleteDialog(
  BuildContext context,
  TodoDTO todo,
) {
  showDialog<void>(
    context: context,
    builder: (_) {
      return UpdateOrDeleteDialog(
        todo: todo,
      );
    },
  );
}

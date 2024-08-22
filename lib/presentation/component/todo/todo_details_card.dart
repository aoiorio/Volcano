import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:volcano/core/config.dart';
import 'package:volcano/infrastructure/dto/todo.dart';
import 'package:volcano/presentation/component/global/bounced_button.dart';
import 'package:volcano/presentation/page/dialogs/update_or_delete_dialog.dart';
import 'package:volcano/presentation/provider/back/todo/controller/todo_controller.dart';
import 'package:volcano/presentation/provider/back/todo/controller/update_todo_controller.dart';

class TodoDetailsCard extends StatefulHookConsumerWidget {
  const TodoDetailsCard({
    super.key,
    required this.todo,
    required this.startColorCode,
    required this.endColorCode,
    this.isGoalInfo = false,
  });

  final TodoDTO todo;
  final int startColorCode;
  final int endColorCode;
  final bool isGoalInfo;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TodoDetailsCardState();
}

class _TodoDetailsCardState extends ConsumerState<TodoDetailsCard> {
  // NOTE this player must be here
  final player = AudioPlayer();

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCompleted = useState(widget.todo.isCompleted ?? false);
    final isListening = useState(false);
    final toast = FToast();

    useEffect(
      () {
        toast.init(context);
        return;
      },
      const [],
    );

    return Center(
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          GestureDetector(
            onTap: () {
              showUpdateOrDeleteDialog(
                context,
                widget.todo,
              );
            },
            child: Container(
              margin: const EdgeInsets.only(
                top: 40,
                bottom: 30,
                right: 30,
                left: 30,
              ),
              padding: const EdgeInsets.all(30),
              alignment: AlignmentDirectional.centerStart,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [
                    Color(widget.startColorCode),
                    Color(widget.endColorCode),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '{',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      widget.isGoalInfo
                          ? '"title": "${widget.todo.title}",\n\n"type": "${widget.todo.type}",\n\n"due date": ${widget.todo.period!.year}/${widget.todo.period!.month}/${widget.todo.period!.day},\n\n"priority": ${widget.todo.priority},\n\n"description": "${widget.todo.description}"'
                          : '"title": "${widget.todo.title}",\n\n"due date": "${widget.todo.period!.year}/${widget.todo.period!.month}/${widget.todo.period!.day}",\n\n"priority": ${widget.todo.priority},\n\n"description": "${widget.todo.description}"',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  Text(
                    '}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          // NOTE audio button and checkbox
          Positioned(
            top: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BouncedButton(
                  onPress: () async {
                    HapticFeedback.lightImpact();
                    final audioSource = LockCachingAudioSource(
                      Uri.parse(
                        widget.todo.audioUrl ?? dummyAudioURL,
                      ),
                    );
                    await player.setAudioSource(
                      audioSource,
                    );
                    if (player.playing) {
                      await player.stop();
                    }
                    if (isListening.value) {
                      await player.stop();
                      isListening.value = false;
                    } else {
                      isListening.value = true;
                      await player.play();
                    }
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.8),
                    ),
                    child: Icon(
                      isListening.value ? Icons.pause : Icons.play_arrow,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                BouncedButton(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xff707070).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: isCompleted.value
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        : const SizedBox(),
                  ),
                  onPress: () {
                    HapticFeedback.lightImpact();
                    isCompleted.value = !isCompleted.value;
                    final updatedTodo = TodoDTO(
                      id: widget.todo.id,
                      todoId: widget.todo.todoId,
                      title: widget.todo.title,
                      description: widget.todo.description,
                      period: widget.todo.period,
                      priority: widget.todo.priority,
                      userId: widget.todo.userId,
                      audioUrl: widget.todo.audioUrl,
                      isCompleted: isCompleted.value,
                      type: widget.todo.type,
                      createdAt: widget.todo.createdAt,
                      updatedAt: widget.todo.updatedAt,
                    );
                    ref
                        .read(todoControllerProvider.notifier)
                        .executeLocalUpdateTodo(updatedTodo);
                    ref
                        .read(
                          updateTodoControllerProvider.notifier,
                        )
                        .executeUpdateIsCompleted(
                          todoId: widget.todo.todoId ?? '',
                          title: widget.todo.title ?? '',
                          description: widget.todo.description ?? '',
                          period: widget.todo.period ?? DateTime.now(),
                          priority: widget.todo.priority ?? 3,
                          audioUrl: widget.todo.audioUrl ?? '',
                          isCompleted: isCompleted.value,
                          type: widget.todo.type ?? 'others',
                          toast: toast,
                        );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

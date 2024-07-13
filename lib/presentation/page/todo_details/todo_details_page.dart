import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:volcano/core/config.dart';
import 'package:volcano/gen/assets.gen.dart';
import 'package:volcano/infrastructure/dto/todo.dart';
import 'package:volcano/presentation/component/global/bounced_button.dart';
import 'package:volcano/presentation/provider/back/todo/controller/todo_controller.dart';
import 'package:volcano/presentation/provider/back/todo/controller/update_todo_controller.dart';
import 'package:volcano/presentation/provider/back/todo/is_completed.dart';
import 'package:volcano/presentation/provider/back/todo/is_playing_voice_of_todo.dart';
import 'package:volcano/presentation/provider/back/type_color_code/type_color_code_controller.dart';
import 'package:volcano/presentation/routes/routes_model/todo_details_route_model.dart';

class TodoDetailsPage extends ConsumerStatefulWidget {
  const TodoDetailsPage({
    super.key,
    required this.todoDetailsRouteModel,
  });

  final TodoDetailsRouteModel todoDetailsRouteModel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TodoDetailsPageState();
}

class _TodoDetailsPageState extends ConsumerState<TodoDetailsPage> {
  final player = AudioPlayer();
  final FToast toast = FToast();

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  void initState() {
    super.initState();
    toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final userTodo = widget.todoDetailsRouteModel.userTodo;
    final typeColorCodeObject = ref
        .read(
          typeColorCodeControllerProvider.notifier,
        )
        .findTypeFromColorList(
          widget.todoDetailsRouteModel.typeName,
        );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        centerTitle: false,
        title: Text(
          '"${widget.todoDetailsRouteModel.typeName}"',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.black),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            highlightColor: Colors.transparent,
            onPressed: () {
              context.pop();
            },
          ),
        ),
        // NOTE make blur to App Bar background
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              highlightColor: Colors.transparent,
              onPressed: () {
                // TODO create filter feature here (pop up)
                debugPrint('Click filter');
              },
              icon: const Icon(
                Icons.tune,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(top: 0, child: Assets.images.todoDetailsRectangle.svg()),
          ListView.builder(
            itemCount: userTodo.length,
            itemBuilder: (context, index) {
              final isPlaying = ref.watch(
                isPlayingVoiceOfTodoProvider(
                  userTodo,
                  userTodo[index].todoId ?? '',
                ),
              );
              final isPlayingNotifier = ref.read(
                isPlayingVoiceOfTodoProvider(
                  userTodo,
                  userTodo[index].todoId ?? '',
                ).notifier,
              );
              if (player.processingState == ProcessingState.completed) {
                isPlayingNotifier.updateIsPlaying(
                  todoId: userTodo[index].todoId ?? '',
                  updatedBool: false,
                );
              }
              final isCompleted = ref.watch(
                isCompletedProvider(
                  userTodo,
                  userTodo[index].todoId ?? '',
                ),
              );
              final isCompletedNotifier = ref.read(
                isCompletedProvider(
                  userTodo,
                  userTodo[index].todoId ?? '',
                ).notifier,
              );
              return Center(
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    // TODO add Geodetecter to update or delete the todo
                    Container(
                      width: 336,
                      margin: const EdgeInsets.only(top: 40, bottom: 30),
                      padding: const EdgeInsets.all(30),
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            Color(
                              int.parse(typeColorCodeObject.startColorCode),
                            ),
                            Color(
                              int.parse(typeColorCodeObject.endColorCode),
                            ),
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
                              '"title": "${userTodo[index].title}",\n"due date": "${userTodo[index].period!.year}/${userTodo[index].period!.month}/${userTodo[index].period!.day}"',
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
                                  userTodo[index].audioUrl ?? dummyAudioURL,
                                ),
                              );
                              await player.setAudioSource(
                                audioSource,
                              );
                              if (isPlaying) {
                                isPlayingNotifier.updateIsPlaying(
                                  todoId: userTodo[index].todoId ?? '',
                                  updatedBool: false,
                                );
                                await player.stop();
                              } else {
                                isPlayingNotifier.updateIsPlaying(
                                  todoId: userTodo[index].todoId ?? '',
                                  updatedBool: true,
                                );

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
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          // DONE create the method that can hold the data of false or true for check box. I think that when I go back to previous page, I can execute the method to update todos
                          BouncedButton(
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xff707070).withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: isCompleted
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                  : const SizedBox(),
                            ),
                            onPress: () {
                              HapticFeedback.lightImpact();
                              isCompletedNotifier.updateIsCompleted(
                                todoId: userTodo[index].todoId ?? '',
                                updatedBool: !isCompleted,
                              );
                              final updatedTodo = TodoDTO(
                                id: userTodo[index].id,
                                todoId: userTodo[index].todoId,
                                title: userTodo[index].title,
                                description: userTodo[index].description,
                                period: userTodo[index].period,
                                priority: userTodo[index].priority,
                                userId: userTodo[index].userId,
                                audioUrl: userTodo[index].audioUrl,
                                isCompleted: !isCompleted,
                                type: userTodo[index].type,
                                createdAt: userTodo[index].createdAt,
                                updatedAt: userTodo[index].updatedAt,
                              );
                              ref
                                  .read(todoControllerProvider.notifier)
                                  .executeLocalUpdateTodo(updatedTodo);
                              ref
                                  .read(updateTodoControllerProvider.notifier)
                                  .executeUpdateTodo(
                                    todoId: userTodo[index].todoId ?? '',
                                    title: userTodo[index].title ?? '',
                                    description:
                                        userTodo[index].description ?? '',
                                    period: userTodo[index].period ??
                                        DateTime.now(),
                                    priority: userTodo[index].priority ?? 3,
                                    audioUrl: userTodo[index].audioUrl ?? '',
                                    isCompleted: !isCompleted,
                                    type: userTodo[index].type ?? 'other',
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
            },
          ),
        ],
      ),
    );
  }
}

// class TodoDetailsPage extends ConsumerWidget {
//   const TodoDetailsPage({
//     super.key,
//     required this.todoDetailsRouteModel,
//   });

//   final TodoDetailsRouteModel todoDetailsRouteModel;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final userTodo = todoDetailsRouteModel.userTodo;
//     final typeColorCodeObject = ref
//         .read(
//           typeColorCodeControllerProvider.notifier,
//         )
//         .findTypeFromColorList(
//           todoDetailsRouteModel.typeName,
//         );
//     final player = AudioPlayer();

//     return Scaffold(
//       // extendBodyBehindAppBar: false,
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         forceMaterialTransparency: true,
//         centerTitle: false,
//         title: Text(
//           '"${todoDetailsRouteModel.typeName}"',
//           style: Theme.of(context)
//               .textTheme
//               .bodyMedium!
//               .copyWith(color: Colors.black),
//         ),
//         leading: Padding(
//           padding: const EdgeInsets.all(8),
//           child: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             highlightColor: Colors.transparent,
//             onPressed: () {
//               context.pop();
//             },
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 20),
//             child: IconButton(
//               highlightColor: Colors.transparent,
//               onPressed: () {
//                 // TODO create filter feature here (pop up)
//                 debugPrint('Click filter');
//               },
//               icon: const Icon(
//                 Icons.tune,
//                 size: 24,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           Positioned(top: 0, child: Assets.images.todoDetailsRectangle.svg()),
//           ListView.builder(
//             itemCount: userTodo.length,
//             itemBuilder: (context, index) {
//               final isPlaying = ref.watch(
//                 isPlayingVoiceOfTodoProvider(
//                   userTodo,
//                   userTodo[index].todoId ?? '',
//                 ),
//               );
//               final isPlayingNotifier = ref.read(
//                 isPlayingVoiceOfTodoProvider(
//                   userTodo,
//                   userTodo[index].todoId ?? '',
//                 ).notifier,
//               );
//               return Center(
//                 child: Stack(
//                   alignment: AlignmentDirectional.topCenter,
//                   children: [
//                     Container(
//                       width: 336,
//                       margin: const EdgeInsets.only(top: 30, bottom: 30),
//                       padding: const EdgeInsets.all(30),
//                       alignment: AlignmentDirectional.center,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30),
//                         gradient: LinearGradient(
//                           colors: [
//                             Color(
//                               int.parse(typeColorCodeObject.startColorCode),
//                             ),
//                             Color(
//                               int.parse(typeColorCodeObject.endColorCode),
//                             ),
//                           ],
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             '{',
//                             style:
//                                 Theme.of(context).textTheme.bodySmall!.copyWith(
//                                       color: Colors.black,
//                                     ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 25),
//                             child: Text(
//                               '"title": "${userTodo[index].title}",\n"due date": "${userTodo[index].period!.year}/${userTodo[index].period!.month}/${userTodo[index].period!.day}"',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodySmall!
//                                   .copyWith(
//                                     color: Colors.black,
//                                   ),
//                             ),
//                           ),
//                           Text(
//                             '}',
//                             style:
//                                 Theme.of(context).textTheme.bodySmall!.copyWith(
//                                       color: Colors.black,
//                                     ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                       top: 6,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: 40,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.black.withOpacity(0.8),
//                             ),
//                             child: IconButton(
//                               padding: EdgeInsets.zero,
//                               icon: Icon(
//                                 isPlaying ? Icons.pause : Icons.play_arrow,
//                                 size: 30,
//                                 color: Colors.white,
//                               ),
//                               onPressed: () async {
//                                 final audioSource = LockCachingAudioSource(
//                                   Uri.parse(
//                                     userTodo[index].audioUrl ?? dummyAudioURL,
//                                   ),
//                                 );
//                                 await player.setAudioSource(
//                                   audioSource,
//                                 );
//                                 if (isPlaying) {
//                                   print('is playing');
//                                   isPlayingNotifier.updateIsPlaying(
//                                     todoId: userTodo[index].todoId ?? '',
//                                     updatedBool: false,
//                                   );
//                                   await player.stop();
//                                   print('stop it');
//                                 } else {
//                                   isPlayingNotifier.updateIsPlaying(
//                                     todoId: userTodo[index].todoId ?? '',
//                                     updatedBool: true,
//                                   );

//                                   await player.play();
//                                 }
//                               },
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           // TODO create the method that can hold the data of false or true for check box. I think that when I go back to previous page, I can execute the method to update todos
//                           Checkbox(
//                             value: userTodo[index].isCompleted,
//                             onChanged: (value) {
//                               print(value);
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
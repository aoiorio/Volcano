import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:volcano/domain/entity/read_todo.dart';
import 'package:volcano/presentation/component/global/bounced_button.dart';
import 'package:volcano/presentation/provider/back/todo/controller/todo_controller.dart';

class TodoListCard extends StatefulHookConsumerWidget {
  const TodoListCard({
    super.key,
    required this.startColorCode,
    required this.endColorCode,
    required this.readTodoList,
    required this.audioSource,
  });

  final int startColorCode;
  final int endColorCode;
  final ReadTodo readTodoList;
  final ConcatenatingAudioSource audioSource;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoListCardState();
}

class _TodoListCardState extends ConsumerState<TodoListCard> {
  // NOTE this player must be here
  final player = AudioPlayer();

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoControllerProvider);

    final isListening = useState(false);
    final valueCount = todos.getRight().fold(() => null, (todo) {
      return widget.readTodoList.values!.length;
    });
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          margin: const EdgeInsets.only(
            bottom: 70,
            right: 30,
            left: 30,
          ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5, // 230
                    child: Text(
                      widget.readTodoList.type.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 22),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // NOTE play audio button
                  BouncedButton(
                    child: Icon(
                      isListening.value ? Icons.pause : Icons.play_arrow,
                      size: 40,
                    ),
                    onPress: () async {
                      HapticFeedback.lightImpact();
                      // LINK - https://zenn.dev/r0227n/articles/085c234061235e
                      if (isListening.value) {
                        isListening.value = false;
                        await player.stop();
                      } else {
                        isListening.value = true;
                        await player.setAudioSource(
                          widget.audioSource,
                        );
                        await player.play();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  // NOTE go to todo details page here
                  context.push(
                    '/todo-details',
                    extra: widget.readTodoList.type,
                  );
                },
                child: ListView.builder(
                  itemCount: valueCount! >= 3 ? 3 : valueCount,
                  // NOTE this shrinkWrap prevents the error of layout
                  shrinkWrap: true,
                  // NOTE this physics can allow to scroll the screen property
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, valueIndex) {
                    final period =
                        widget.readTodoList.values![valueIndex].period;
                    // NOTE displaying todo here
                    final todoWidget = Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),

                      // NOTE the todo of type
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '{',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                            ),
                            child: Text(
                              '"title": "${widget.readTodoList.values![valueIndex].title}",\n\n"due date": "${period!.year}/${period.month}/${period.day}"',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                          ),
                          Text(
                            '}',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                        ],
                      ),
                    );
                    return todoWidget;
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),

        // NOTE Next Button
        Positioned(
          bottom: 40,
          child: BouncedButton(
            // DONE create going to the todo page
            onPress: () {
              HapticFeedback.lightImpact();
              context.push(
                '/todo-details',
                extra: widget.readTodoList.type,
              );
            },
            child: Container(
              width: 100,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xffE1E1E1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '"',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff4D3769),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_outlined,
                    color: Color(0xff4D3769),
                  ),
                  Text(
                    '"',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff4D3769),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

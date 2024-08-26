import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:volcano/gen/assets.gen.dart';
import 'package:volcano/infrastructure/dto/todo.dart';
import 'package:volcano/presentation/component/todo/todo_details_card.dart';
import 'package:volcano/presentation/provider/back/todo/controller/todo_controller.dart';
import 'package:volcano/presentation/provider/back/type_color_code/type_color_code_controller.dart';

class TodoDetailsPage extends ConsumerStatefulWidget {
  const TodoDetailsPage({
    super.key,
    required this.typeName,
  });

  final String typeName;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TodoDetailsPageState();
}

class _TodoDetailsPageState extends ConsumerState<TodoDetailsPage> {
  final player = AudioPlayer();
  final FToast toast = FToast();
  int typeIndex = 0;

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
    final typeIndex = ref
        .watch(todoControllerProvider.notifier)
        .executeGetTypeIndex(widget.typeName);
    final userTodo = ref
        .watch(todoControllerProvider)
        .getRight()
        .fold(() => <TodoDTO>[], (readTodoList) {
      if (typeIndex == -1) {
        return <TodoDTO>[];
      }
      return readTodoList[typeIndex!].values ?? [];
    });

    final typeColorCodeObject = ref
        .read(
          typeColorCodeControllerProvider.notifier,
        )
        .findTypeFromColorList(
          widget.typeName,
        );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        centerTitle: false,
        title: Text(
          '"${widget.typeName}"',
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
        actions: const [
          // NOTE filter feature
          // Padding(
          //   padding: const EdgeInsets.only(right: 10),
          //   child: IconButton(
          //     highlightColor: Colors.transparent,
          //     onPressed: () {
          // TODO create filter feature here (pop up)
          //       debugPrint('Click filter');
          //     },
          //     icon: const Icon(
          //       Icons.tune,
          //       size: 24,
          //     ),
          //   ),
          // ),
        ],
      ),
      body: Stack(
        children: [
          MediaQuery.of(context).size.width >= 800
              ? ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xffBABBC8), Color(0xffC6C3C3)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                )
              : Positioned(
                  top: 0,
                  child: Assets.images.todoDetailsRectangle.svg(),
                ),
          userTodo.isEmpty
              ? const Center(
                  child: Text(
                    '"No Todo Found"',
                  ),
                )
              : ListView.builder(
                  itemCount: userTodo.length,
                  itemBuilder: (context, index) {
                    // NOTE run rebuild when todo changed
                    return TodoDetailsCard(
                      todo: userTodo[index],
                      startColorCode:
                          int.parse(typeColorCodeObject.startColorCode),
                      endColorCode: int.parse(typeColorCodeObject.endColorCode),
                    );
                  },
                ),
        ],
      ),
    );
  }
}

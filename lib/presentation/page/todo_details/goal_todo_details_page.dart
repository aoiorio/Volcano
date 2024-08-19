import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:volcano/gen/assets.gen.dart';
import 'package:volcano/infrastructure/dto/todo.dart';
import 'package:volcano/presentation/component/todo/todo_details_card.dart';
import 'package:volcano/presentation/provider/back/todo/controller/goal_info_getter.dart';

enum GoalType {
  today,
  month,
}

class GoalTodoDetailsPage extends HookConsumerWidget {
  const GoalTodoDetailsPage({
    super.key,
    required this.goalType,
  });

  final GoalType goalType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleName =
        goalType == GoalType.today ? "Today's TODO" : "Month's TODO";
    final todoList = ref.watch(goalInfoGetterProvider).getRight().fold(
          () => <TodoDTO>[],
          (goalInfo) => goalType == GoalType.today
              ? goalInfo.todayGoal!.todayTodo ?? []
              : goalInfo.monthGoal!.monthTodo ?? [],
        );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        centerTitle: false,
        title: Text(
          '"$titleName"',
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
          MediaQuery.of(context).size.width >= 850
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
              : Positioned(top: 0, child: Assets.images.todoDetailsRectangle.svg()),
          todoList.isEmpty
              ? const Center(
                  child: Text(
                    '"No Todo Found"',
                  ),
                )
              : ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    // NOTE run rebuild when todo changed
                    return TodoDetailsCard(
                      todo: todoList[index],
                      startColorCode:
                          goalType == GoalType.today ? 0xffAEADB9 : 0xffBCBCB4,
                      endColorCode: 0xffBABBBA,
                      isGoalInfo: true,
                    );
                  },
                ),
        ],
      ),
    );
  }
}

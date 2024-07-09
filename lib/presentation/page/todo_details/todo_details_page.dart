import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volcano/presentation/component/global/bounced_button.dart';
import 'package:volcano/presentation/routes/routes_model/todo_details_route_model.dart';

class TodoDetailsPage extends ConsumerWidget {
  const TodoDetailsPage({
    super.key,
    required this.todoDetailsRouteModel,
  });

  final TodoDetailsRouteModel todoDetailsRouteModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userTodo = todoDetailsRouteModel.userTodo;

    return Scaffold(
      appBar: AppBar(
        title: Text('"${todoDetailsRouteModel.typeName}"'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: BouncedButton(
              onPress: () {
                // TODO create filter feature here (pop up)
                debugPrint('Click filter');
              },
              child: const Icon(Icons.tune),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: userTodo.length,
        itemBuilder: (context, index) {
          return Text(userTodo[index].description ?? '');
        },
      ),
    );
  }
}

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/goal_percentage.dart';
import 'package:volcano/presentation/provider/back/auth/shared_preference.dart';
import 'package:volcano/presentation/provider/back/todo/providers.dart';

part 'goal_percentage_controller.g.dart';

@riverpod
class GoalPercentageController extends _$GoalPercentageController {
  @override
  Either<BackEndError, GoalPercentage> build() {
    return Either.right(GoalPercentage());
  }

  void executeGetGoalPercentage() {
    final token = ref.read(authSharedPreferenceProvider);
    ref
        .read(todoUseCaseProvider)
        .executeGetGoalPercentage(token: token)
        .then((value) {
      if (value.isRight()) {
        value.getRight().fold(() => null, (goalPercentage) {
          state = Either.right(goalPercentage);
        });
      } else if (value.isLeft()) {
        state = Either.left(BackEndError(statusCode: 404));
        // do something here
      }
    });
  }
}

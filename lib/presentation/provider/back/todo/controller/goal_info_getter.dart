import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/infrastructure/dto/goal_info.dart';
import 'package:volcano/presentation/component/global/custom_toast.dart';
import 'package:volcano/presentation/provider/back/auth/shared_preference.dart';
import 'package:volcano/presentation/provider/back/todo/providers.dart';

part 'goal_info_getter.g.dart';

@riverpod
class GoalInfoGetter extends _$GoalInfoGetter {
  @override
  Either<BackEndError, GoalInfo> build() {
    return Either.left(BackEndError(statusCode: 100));
  }

  void executeGetGoalInfo({required FToast toast}) {
    final token = ref.read(authSharedPreferenceProvider);
    ref
        .read(todoUseCaseProvider)
        .executeGetGoalInfo(token: token)
        .then((value) {
      if (value.isRight()) {
        value.getRight().fold(() => null, (goalPercentage) {
          state = Either.right(goalPercentage);
        });
      } else if (value.isLeft()) {
        state = Either.left(BackEndError(statusCode: 404));
        // NOTE for avoiding the message, if the token is empty
        if (ref.read(authSharedPreferenceProvider).isEmpty) {
          return;
        }
        // do something here
        showToastMessage(
          toast,
          '😵‍💫 Something went wrong with goals',
          ToastWidgetKind.error,
        );
      }
    });
  }
}

import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// NOTE Project Packages
import 'package:volcano/core/errors.dart';
import 'package:volcano/infrastructure/dto/token.dart';
import 'package:volcano/presentation/component/global/custom_toast.dart';
import 'package:volcano/presentation/provider/back/auth/providers.dart';
import 'package:volcano/presentation/provider/back/auth/shared_preference.dart';
import 'package:volcano/presentation/provider/front/auth/sign_up_providers.dart';
import 'package:volcano/presentation/provider/global/progress_controller.dart';

part 'sign_up_controller.g.dart';

@riverpod
class AuthExecuteSignUpController extends _$AuthExecuteSignUpController {
  @override
  Either<BackEndError, TokenDTO> build() {
    return Either.left(BackEndError());
  }

  void executeSignUp(FToast toast) {
    final authUseCase = ref.read(authUseCaseProvider);
    final authSharedPreferenceNotifier =
        ref.watch(authSharedPreferenceProvider.notifier);

    ref
        .read(progressControllerProvider.notifier)
        .executeWithProgress(
          authUseCase.executeSignUp(
            email: ref.read(signUpEmailTextControllerProvider).text,
            password: ref.read(signUpPasswordTextControllerProvider).text,
            confirmPassword:
                ref.read(signUpConfirmPasswordTextControllerProvider).text,
          ),
        )
        .then(
      (value) {
        if (value.isRight()) {
          // NOTE users can't go back this page if they pushed this button
          showToastMessage(
            toast,
            "💡 You've Signed Up!",
            ToastWidgetKind.success,
          );
          // NOTE set accessToken to Local Storage
          value.foldRight(BackEndError, (acc, result) {
            authSharedPreferenceNotifier
              ..setAccessToken(result.accessToken ?? '')
              // NOTE get Access Token so it'll set AccessToken.
              ..getAccessToken();
            return acc;
          });
        } else if (value.isLeft()) {
          value.getLeft().fold(() => null, (error) {
            final errorMessage =
                error.message?.detail.toString() ?? 'Something went wrong';
            showToastMessage(
              toast,
              '😵‍💫 $errorMessage',
              ToastWidgetKind.error,
            );
          });
        }
      },
    );
  }
}

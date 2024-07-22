import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/infrastructure/dto/token.dart';
import 'package:volcano/presentation/component/global/custom_toast.dart';
import 'package:volcano/presentation/provider/back/auth/providers.dart';
import 'package:volcano/presentation/provider/back/auth/shared_preference.dart';
import 'package:volcano/presentation/provider/front/auth/sign_in_providers.dart';
import 'package:volcano/presentation/provider/front/auth/sign_up_providers.dart';
import 'package:volcano/presentation/provider/global/progress_controller.dart';

part 'sign_in_controller.g.dart';

@riverpod
class AuthExecuteSignInController extends _$AuthExecuteSignInController {
  @override
  Either<BackEndError, TokenDTO> build() {
    return Either.left(BackEndError());
  }

  void executeSignIn(FToast toast, BuildContext context) {
    final authUseCase = ref.read(authUseCaseProvider);
    final authSharedPreferenceNotifier =
        ref.watch(authSharedPreferenceProvider.notifier);

    ref.read(progressControllerProvider.notifier).executeWithProgress(
          authUseCase
              .executeSignIn(
            email: ref.read(signInEmailTextControllerProvider).text,
            password: ref.read(signInPasswordTextControllerProvider).text,
          )
              .then((value) {
            if (value.isRight()) {
              // NOTE users can't go back this page if they pushed this button
              showToastMessage(
                toast,
                "💡 You've Signed In!",
                ToastWidgetKind.success,
              );
              // NOTE set accessToken to Local Storage
              value.getRight().fold(() => null, (token) {
                authSharedPreferenceNotifier
                  ..setAccessToken(token.accessToken ?? '')
                  // NOTE get Access Token so it'll set AccessToken.
                  ..getAccessToken();
              });

              // NOTE reset values
              ref.read(signInEmailTextControllerProvider.notifier).state.text =
                  '';
              ref
                  .read(signInPasswordTextControllerProvider.notifier)
                  .state
                  .text = '';
              ref.read(signUpEmailTextControllerProvider.notifier).state.text =
                  '';
              ref
                  .read(signUpPasswordTextControllerProvider.notifier)
                  .state
                  .text = '';
              ref
                  .read(signUpConfirmPasswordTextControllerProvider.notifier)
                  .state
                  .text = '';
              ref.read(signInEmailStatusProvider.notifier).state = false;
              ref.read(signInPasswordStatusProvider.notifier).state = false;
              ref.read(signUpEmailStatusProvider.notifier).state = false;
              ref.read(signUpPasswordStatusProvider.notifier).state = false;
              ref.read(signUpConfirmPasswordStatusProvider.notifier).state =
                  false;
              // NOTE go to VolcanoPage
              context.pushReplacement('/volcano');
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
            } else {
              showToastMessage(
                toast,
                'Something went wrong',
                ToastWidgetKind.error,
              );
            }
            return Either.right('DONE');
          }),
        );
  }
}

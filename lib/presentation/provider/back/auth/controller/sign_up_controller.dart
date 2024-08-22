import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// NOTE Project Packages
import 'package:volcano/core/errors.dart';
import 'package:volcano/infrastructure/dto/token.dart';
import 'package:volcano/presentation/component/global/custom_toast.dart';
import 'package:volcano/presentation/provider/back/auth/providers.dart';
import 'package:volcano/presentation/provider/back/auth/shared_preference.dart';
import 'package:volcano/presentation/provider/front/auth/sign_in_providers.dart';
import 'package:volcano/presentation/provider/front/auth/sign_up_providers.dart';
import 'package:volcano/presentation/provider/global/progress_controller.dart';

part 'sign_up_controller.g.dart';

@riverpod
class AuthExecuteSignUpController extends _$AuthExecuteSignUpController {
  @override
  Either<BackEndError, TokenDTO> build() {
    return Either.left(BackEndError());
  }

  void executeSignUp(FToast toast, BuildContext context) {
    final authUseCase = ref.read(authUseCaseProvider);
    final authSharedPreferenceNotifier =
        ref.watch(authSharedPreferenceProvider.notifier);

    ref.read(progressControllerProvider.notifier).executeWithProgress(
          authUseCase
              .executeSignUp(
            email: ref.read(signUpEmailTextControllerProvider).text,
            password: ref.read(signUpPasswordTextControllerProvider).text,
            confirmPassword:
                ref.read(signUpConfirmPasswordTextControllerProvider).text,
          )
              .then((value) {
            if (value.isRight()) {
              // NOTE users can't go back this page if they pushed this button
              showToastMessage(
                toast,
                "💡 You've Signed Up!",
                ToastWidgetKind.success,
              );
              // NOTE set accessToken to Local Storage
              value.getRight().fold(() => null, (token) {
                authSharedPreferenceNotifier
                  ..setAccessToken(token.accessToken ?? '')
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
              context.pushReplacement('/');
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
            return Either.right('DONE');
          }),
        );
  }
}

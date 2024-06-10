import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// NOTE Project Packages
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/token.dart';
import 'package:volcano/presentation/component/custom_toast.dart';
import 'package:volcano/presentation/provider/back/auth/auth_providers.dart';
import 'package:volcano/presentation/provider/back/auth/auth_shared_preference.dart';
import 'package:volcano/presentation/provider/front/sign_up/sign_up_page_providers.dart';
import 'package:volcano/presentation/provider/global/progress_controller.dart';

part 'auth_execute_methods_controller.g.dart';

@riverpod
class AuthExecuteSignUpController extends _$AuthExecuteSignUpController {
  @override
  Either<AuthError, Token> build() {
    return Either.left(AuthError());
  }

  void executeSignUp(FToast toast) {
    final authUseCase = ref.read(authUseCaseProvider);
    final authSharedPreferenceNotifier =
        ref.watch(authSharedPreferenceProvider.notifier);
    final authSharedPreference = ref.watch(authSharedPreferenceProvider);

    ref
        .read(progressControllerProvider.notifier)
        .executeWithProgress(
          authUseCase.executeSignUp(
            email: ref.read(emailTextControllerProvider).text,
            password: ref.read(passwordTextControllerProvider).text,
            confirmPassword:
                ref.read(confirmPasswordTextControllerProvider).text,
          ),
        )
        .then(
      (value) {
        if (value.isRight()) {
          // NOTE users can't go back this page if they pushed this button
          showToastMessage(
            toast,
            "💡 You've signed Up!",
            ToastWidgetKind.success,
          );
          // NOTE set accessToken to Local Storage
          value.foldRight(AuthError, (acc, result) {
            authSharedPreferenceNotifier
              ..setAccessToken(result.accessToken ?? '')
              ..getAccessToken();
            debugPrint(authSharedPreference);
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

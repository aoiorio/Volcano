import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:volcano/presentation/component/sign_up/sign_up_step_shape.dart';

final signUpStepCounterProvider = StateProvider((ref) => 0);

final signUpEmailTextControllerProvider =
    StateProvider((ref) => TextEditingController());

final signUpPasswordTextControllerProvider =
    StateProvider((ref) => TextEditingController());

final signUpConfirmPasswordTextControllerProvider =
    StateProvider((ref) => TextEditingController());

// NOTE family means that return TextEditingController value and get String value
final signUpTextEditingControllerProvider =
    StateProvider.family<TextEditingController, TextEditingControllerType>(
        (ref, type) {
  return type == TextEditingControllerType.email
      ? ref.watch(signUpEmailTextControllerProvider)
      : type == TextEditingControllerType.password
          ? ref.watch(signUpPasswordTextControllerProvider)
          : ref.watch(signUpConfirmPasswordTextControllerProvider);
});

// NOTE it is for signup page texts
final signUpTextControllerTextProvider =
    StateProvider.family<String, String>((ref, text) {
  return text.contains('Email')
      ? ref.watch(signUpEmailTextControllerProvider).text
      : text.contains('Password')
          ? ref.watch(signUpPasswordTextControllerProvider).text
          : ref.watch(signUpConfirmPasswordTextControllerProvider).text;
});

final signUpEmailStatusProvider = StateProvider((ref) => false);

final signUpPasswordStatusProvider = StateProvider((ref) => false);

final signUpConfirmPasswordStatusProvider = StateProvider((ref) => false);

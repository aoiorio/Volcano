import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod/riverpod.dart';

final stepCounterProvider = StateProvider((ref) => 0);

final emailTextControllerProvider =
    StateProvider((ref) => TextEditingController());

final passwordTextControllerProvider =
    StateProvider((ref) => TextEditingController());

final confirmPasswordTextControllerProvider =
    StateProvider((ref) => TextEditingController());

// NOTE family means that return TextEditingController value and get String value
final signUpTextEditingControllerProvider =
    StateProvider.family<TextEditingController, String>((ref, text) {
  return text.contains("email")
      ? ref.watch(emailTextControllerProvider)
      : text.contains("password")
          ? ref.watch(passwordTextControllerProvider)
          : ref.watch(confirmPasswordTextControllerProvider);
});

// NOTE it is for signup page texts
final signUpTextControllerTextProvider =
    StateProvider.family<String, String>((ref, text) {
  return text.contains("Email")
      ? ref.watch(emailTextControllerProvider).text
      : text.contains("Password")
          ? ref.watch(passwordTextControllerProvider).text
          : ref.watch(confirmPasswordTextControllerProvider).text;
});

final emailStatusProvider = StateProvider((ref) => false);

final passwordStatusProvider = StateProvider((ref) => false);

final confirmPasswordStatusProvider = StateProvider((ref) => false);

final isSignUpLoadingProvider = StateProvider((ref) => false);

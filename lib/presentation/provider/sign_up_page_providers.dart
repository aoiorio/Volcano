import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

final stepCounterProvider = StateProvider((ref) => 0);

final emailTextControllerProvider =
    StateProvider((ref) => TextEditingController());

final passwordTextControllerProvider =
    StateProvider((ref) => TextEditingController());

final confirmPasswordTextControllerProvider =
    StateProvider((ref) => TextEditingController());

final isEmailFilledProvider = StateProvider((ref) => false);

final isPasswordFilledProvider = StateProvider((ref) => false);

final isConfirmPasswordFilledProvider = StateProvider((ref) => false);

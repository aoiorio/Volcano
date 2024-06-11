import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInStepCounterProvider = StateProvider((ref) => 0);

final signInEmailTextControllerProvider =
    StateProvider((ref) => TextEditingController());

final signInPasswordTextControllerProvider =
    StateProvider((ref) => TextEditingController());

final signInTextEditingControllerProvider =
    StateProvider.family<TextEditingController, String>((ref, text) {
  return text.contains('email')
      ? ref.watch(signInEmailTextControllerProvider)
      : ref.watch(signInPasswordTextControllerProvider);
});

final signInEmailStatusProvider = StateProvider((ref) => false);

final signInPasswordStatusProvider = StateProvider((ref) => false);

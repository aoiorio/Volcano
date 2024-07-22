import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volcano/presentation/component/sign_up/sign_up_step_shape.dart';

final signInStepCounterProvider = StateProvider((ref) => 0);

final signInEmailTextControllerProvider =
    StateProvider((ref) => TextEditingController());

final signInPasswordTextControllerProvider =
    StateProvider((ref) => TextEditingController());

final signInTextEditingControllerProvider =
    StateProvider.family<TextEditingController, TextEditingControllerType>(
        (ref, type) {
  return type == TextEditingControllerType.email
      ? ref.watch(signInEmailTextControllerProvider)
      : ref.watch(signInPasswordTextControllerProvider);
});

final signInEmailStatusProvider = StateProvider((ref) => false);

final signInPasswordStatusProvider = StateProvider((ref) => false);

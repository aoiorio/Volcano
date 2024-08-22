import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_listening_controller.g.dart';

@riverpod
class VoiceRecognitionIsListeningController
    extends _$VoiceRecognitionIsListeningController {
  @override
  bool build() {
    return false;
  }

  void changeToTrue() {
    state = true;
  }

  void changeToFalse() {
    state = false;
  }
}

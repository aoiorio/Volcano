import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:volcano/presentation/provider/front/todo/voice_recognition/is_listening_controller.dart';

part 'voice_recognition_controller.g.dart';

// @riverpod
// bool isPreparingForRecognizing(Ref ref, {bool? isPreparing}) {
//   return isPreparing ?? false;
// }

@riverpod
class VoiceRecognitionController extends _$VoiceRecognitionController {
  @override
  String build(SpeechToText speechToText) {
    return 'title create something';
  }

  void recognizeVoice(SpeechToText speechToText) {
    final isListening =
        ref.watch(voiceRecognitionIsListeningControllerProvider);
    if (!isListening) {
      ref
          .read(voiceRecognitionIsListeningControllerProvider.notifier)
          .changeToTrue();
      speechToText.listen(
        onResult: (result) {
          state = result.recognizedWords;
        },
      );
    } else {
      stopRecognizing(speechToText);
    }
  }

  void stopRecognizing(SpeechToText speechToText) {
    ref
        .read(voiceRecognitionIsListeningControllerProvider.notifier)
        .changeToFalse();
    speechToText.stop();
  }
}

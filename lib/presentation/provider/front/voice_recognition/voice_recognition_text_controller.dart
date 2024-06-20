import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:volcano/presentation/provider/front/voice_recognition/voice_recognition_is_listening_controller.dart';

part 'voice_recognition_text_controller.g.dart';

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
      ref
          .read(voiceRecognitionIsListeningControllerProvider.notifier)
          .changeToFalse();
      stopRecognizing(speechToText);
    }
  }

  void stopRecognizing(SpeechToText speechToText) {
    speechToText.stop();
    // state = 'Say Something';
  }
}

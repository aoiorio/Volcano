import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:volcano/core/config.dart';
import 'package:volcano/presentation/provider/front/todo/voice_recognition/is_listening_controller.dart';

part 'voice_recognition_controller.g.dart';

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
          var recognizedWords =
              result.recognizedWords.replaceAll('.', ' period');

          // NOTE change text numbers like one, two to 1, 2
          for (final i in voiceToNumbersDic.keys.toList()) {
            recognizedWords = recognizedWords
                .toLowerCase()
                .replaceAll(i, voiceToNumbersDic[i].toString());
          }
          state = recognizedWords;
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

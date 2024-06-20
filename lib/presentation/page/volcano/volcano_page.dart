import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:volcano/presentation/provider/back/todo/todo_providers.dart';
import 'package:volcano/presentation/provider/front/voice_recognition/voice_recognition_is_listening_controller.dart';
import 'package:volcano/presentation/provider/front/voice_recognition/voice_recognition_text_controller.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:volcano/presentation/provider/back/auth/auth_shared_preference.dart';
// import 'package:volcano/presentation/provider/back/user/user_providers.dart';

class VolcanoPage extends ConsumerWidget {
  const VolcanoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final player = AudioPlayer(); // Create a player
    // final userUseCase = ref.read(userUseCaseProvider);
    // final authSharedPreference = ref.watch(authSharedPreferenceProvider);
    final speechToText = SpeechToText();
    final isListening =
        ref.watch(voiceRecognitionIsListeningControllerProvider);
    final recognizedText =
        ref.watch(voiceRecognitionControllerProvider(speechToText));
    final voiceRecognitionControllerNotifier =
        ref.watch(voiceRecognitionControllerProvider(speechToText).notifier);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: ElevatedButton(
                onPressed: () async {
                  // ANCHOR - Use LockCachingAudioSource to set the URL
                  // final audioSource = LockCachingAudioSource(
                  //   Uri.parse(
                  //     'https://s3.tebi.io/volcano-bucket/Caffeine-36-50.m4a',
                  //   ),
                  // );
                  // await player.setAudioSource(audioSource);
                  // await player.play();

                  // userUseCase.executeReadUser(authSharedPreference);
                  await speechToText.initialize();

                  // if (speechToText.isListening) {
                  //   voiceRecognitionControllerNotifier
                  //       .stopRecognizing(speechToText);
                  // }

                  if (await speechToText.hasPermission) {
                    voiceRecognitionControllerNotifier
                        .recognizeVoice(speechToText);
                  }
                  // DONE send the result (recognizedText) to back-end and get the todo entity from it
                  // TODO after the user confirmed their stodo and if they push the "add todo" button, the todo entity and the audio file will send to back-end as well
                },
                child: isListening
                    ? const Icon(Icons.stop)
                    : const Icon(
                        Icons.keyboard_voice_outlined,
                        size: 50,
                      ),
              ),
            ),
            Text(recognizedText),
            ElevatedButton(
              onPressed: () {
                debugPrint(recognizedText);
                if (recognizedText.isEmpty) {
                  return;
                }
                ref
                    .read(todoUseCaseProvider)
                    .executeTextToTodo(voiceText: recognizedText);
              },
              child: const Row(
                children: [
                  Icon(Icons.explore),
                  Text('Convert text to todo'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:record/record.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:volcano/presentation/component/global/custom_toast.dart';
import 'package:volcano/presentation/provider/back/todo/controller/post_todo_controller.dart';
import 'package:volcano/presentation/provider/back/todo/controller/text_to_todo_controller.dart';
import 'package:volcano/presentation/provider/front/todo/record_voice/record_voice_controller.dart';
import 'package:volcano/presentation/provider/front/todo/voice_recognition/is_listening_controller.dart';
import 'package:volcano/presentation/provider/front/todo/voice_recognition/voice_recognition_controller.dart';

// ANCHOR - Use LockCachingAudioSource to set the URL
// final audioSource = LockCachingAudioSource(
//   Uri.parse(
//     'https://s3.tebi.io/volcano-bucket/Caffeine-36-50.m4a',
//   ),
// );
// await player.setAudioSource(audioSource);
// await player.play();
class VolcanoPage extends ConsumerStatefulWidget {
  const VolcanoPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VolcanoPageState();
}

class _VolcanoPageState extends ConsumerState<VolcanoPage> {
  final recorder = AudioRecorder();
  final FToast toast = FToast();

  @override
  void dispose() {
    super.dispose();
    recorder.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
    final postTodoController = ref.watch(postTodoControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    await speechToText.initialize();
                    if (speechToText.isListening || isListening) {
                      ref
                          .read(recordVoiceControllerProvider.notifier)
                          .stopRecording(recorder);
                      voiceRecognitionControllerNotifier
                          .stopRecognizing(speechToText);
                    } else if (await recorder.hasPermission() &&
                        await speechToText.hasPermission) {
                      ref
                          .read(recordVoiceControllerProvider.notifier)
                          .startRecording(recorder);
                      voiceRecognitionControllerNotifier
                          .recognizeVoice(speechToText);
                    } else {
                      showToastMessage(
                        toast,
                        'Please allow to record the audio',
                        ToastWidgetKind.error,
                      );
                    }
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
                      .read(textToTodoControllerProvider.notifier)
                      .executeTextToTodo(recognizedText);
                },
                child: const Row(
                  children: [
                    Icon(Icons.explore),
                    Text('Convert text to todo'),
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(postTodoControllerProvider.notifier).postTodo();
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.add_shopping_cart),
                      Text('Add Todo'),
                    ],
                  ),
                ),
              ),
              TextField(
                controller: postTodoController.titleTextController,
                style: const TextStyle(color: Colors.black),
              ),
              TextField(
                controller: postTodoController.descriptionTextController,
                style: const TextStyle(color: Colors.black),
              ),
              TextField(
                controller: postTodoController.typeTextController,
                style: const TextStyle(color: Colors.black),
              ),
              Text(postTodoController.period.toString()),
              Text(postTodoController.priority.toString()),
            ],
          ),
        ),
      ),
    );
  }
}

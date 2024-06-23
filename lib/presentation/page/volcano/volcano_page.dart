import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:record/record.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:volcano/gen/assets.gen.dart';
import 'package:volcano/presentation/component/global/bounced_button.dart';
import 'package:volcano/presentation/component/global/custom_toast.dart';
import 'package:volcano/presentation/provider/back/todo/controller/post_todo_controller.dart';
import 'package:volcano/presentation/provider/back/todo/controller/text_to_todo_controller.dart';
import 'package:volcano/presentation/provider/front/todo/record_voice/record_voice_with_wave.dart';
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
  RecorderController controller = RecorderController();

  @override
  void dispose() {
    super.dispose();
    recorder.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final speechToText = SpeechToText();
    final _isListening =
        ref.watch(voiceRecognitionIsListeningControllerProvider);
    final recognizedText =
        ref.watch(voiceRecognitionControllerProvider(speechToText));
    final voiceRecognitionControllerNotifier =
        ref.watch(voiceRecognitionControllerProvider(speechToText).notifier);
    final postTodoController = ref.watch(postTodoControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
      // extendBodyBehindAppBar: true,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            // alignment: Alignment.center,
            alignment: Alignment.topCenter,
            children: [
              // TODO create svg for ipad (change the size and so on)!!
              Assets.images.volcanoPageShape.svg(),
              Column(
                children: [
                  // const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: Assets.images.volcanoLogo.image(width: 180),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: SizedBox(
                      width: 320,
                      height: 300,
                      child: BouncedButton(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: [
                                _isListening
                                    ? const Color.fromARGB(255, 124, 125, 141)
                                    : const Color(0xff9596AE),
                                _isListening
                                    ? const Color.fromARGB(255, 180, 166, 166)
                                    : const Color(0xffCDBFBF),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 90,
                                child: _isListening
                                    ? AudioWaveforms(
                                        size: Size(
                                          MediaQuery.of(context).size.width / 2,
                                          80,
                                        ),
                                        recorderController: ref.watch(
                                          recordVoiceWithWaveControllerProvider,
                                        ),
                                        waveStyle: const WaveStyle(
                                          waveColor: Colors.black,
                                          extendWaveform: true,
                                          showMiddleLine: false,
                                        ),
                                      )
                                    : const Icon(
                                        Icons.keyboard_voice_outlined,
                                        size: 90,
                                      ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                _isListening
                                    ? '"Speak Details of Todo"'
                                    : '"Add Todo From Voice"',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        onPress: () async {
                          HapticFeedback.mediumImpact();
                          await speechToText.initialize();
                          final hasPermission = await ref
                              .watch(recordVoiceWithWaveControllerProvider)
                              .checkPermission();

                          if (speechToText.isListening || _isListening) {
                            ref
                                .read(
                                  recordVoiceWithWaveControllerProvider
                                      .notifier,
                                )
                                .stopRecordingWithWave();
                            voiceRecognitionControllerNotifier
                                .stopRecognizing(speechToText);
                            // TODO add execute TextToTodo method here
                          } else if (hasPermission) {
                            ref
                                .read(
                                  recordVoiceWithWaveControllerProvider
                                      .notifier,
                                )
                                .startRecordingWithWave();
                            voiceRecognitionControllerNotifier
                                .recognizeVoice(speechToText);
                          } else {
                            showToastMessage(
                              toast,
                              'Please allow the \n permission in Settings',
                              ToastWidgetKind.error,
                            );
                          }
                        },
                      ),
                    ),
                  ),

                  // Text(recognizedText),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     debugPrint(recognizedText);
                  //     if (recognizedText.isEmpty) {
                  //       return;
                  //     }
                  //     ref
                  //         .read(textToTodoControllerProvider.notifier)
                  //         .executeTextToTodo(recognizedText);
                  //   },
                  //   child: const Row(
                  //     children: [
                  //       Icon(Icons.explore),
                  //       Text('Convert text to todo'),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 300,
                  //   width: 300,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       ref
                  //           .read(postTodoControllerProvider.notifier)
                  //           .postTodo();
                  //     },
                  //     child: const Row(
                  //       children: [
                  //         Icon(Icons.add_shopping_cart),
                  //         Text('Add Todo'),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  // TextField(
                  //   controller: postTodoController.titleTextController,
                  //   style: const TextStyle(color: Colors.black),
                  // ),
                  // TextField(
                  //   controller: postTodoController.descriptionTextController,
                  //   style: const TextStyle(color: Colors.black),
                  // ),
                  // TextField(
                  //   controller: postTodoController.typeTextController,
                  //   style: const TextStyle(color: Colors.black),
                  // ),
                  // Text(postTodoController.period.toString()),
                  // Text(postTodoController.priority.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

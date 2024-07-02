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
import 'package:volcano/presentation/page/todo/add_todo_dialog.dart';
import 'package:volcano/presentation/provider/back/todo/controller/todo_controller.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(todoControllerProvider.notifier).executeReadTodo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoControllerProvider);
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
        forceMaterialTransparency: true,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Center(
          child: Stack(
            // alignment: Alignment.center,
            alignment: Alignment.topCenter,
            children: [
              // TODO create svg for ipad (change the size and so on)!!
              Assets.images.volcanoPageShape.svg(),
              Column(
                children: [
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
                                isListening
                                    ? const Color.fromARGB(255, 124, 125, 141)
                                    : const Color(0xff9596AE),
                                isListening
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
                                child: isListening
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
                                isListening
                                    ? '"Speak Details of TODO"'
                                    : '"Add TODO From Voice"',
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

                          if (speechToText.isListening || isListening) {
                            ref
                                .read(
                                  recordVoiceWithWaveControllerProvider
                                      .notifier,
                                )
                                .stopRecordingWithWave();
                            voiceRecognitionControllerNotifier
                                .stopRecognizing(speechToText);
                            // DONE add execute TextToTodo method here
                            if (recognizedText.isEmpty) {
                              return showToastMessage(
                                toast,
                                'Please tell us your TODO',
                                ToastWidgetKind.error,
                              );
                            }
                            if (!context.mounted) {
                              return;
                            }
                            // NOTE convert text that I recognized to todo
                            ref
                                .read(textToTodoControllerProvider.notifier)
                                .executeTextToTodo(
                                  recognizedText,
                                  toast,
                                  context,
                                );
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
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 340,
                    height: 80,
                    child: BouncedButton(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffAAAAAA),
                              Color(0xffB9ACAC),
                            ],
                          ),
                        ),
                        child: Container(
                          // NOTE to text be center, I am using Container
                          alignment: Alignment.center,
                          child: Text(
                            '"Add TODO From Text"',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                      onPress: () {
                        // DONE implement add todo from text feature! (go to AddTodoPage)
                        showAddTodoDialog(context, isAddingFromText: true);
                      },
                    ),
                  ),
                  todos.isLeft()
                      ? const Text('Something went wrong')
                      : ListView.builder(
                          itemCount: ref
                              .watch(todoControllerProvider.notifier)
                              .typeCount,
                          // NOTE this shrinkWrap prevents the error of layout
                          shrinkWrap: true,
                          // NOTE this physics can allow to scroll the screen property
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, typeIndex) {
                            final valueCount =
                                todos.getRight().fold(() => null, (todo) {
                              return todo[typeIndex].values!.length;
                            });
                            // print('type count is here');
                            // print(ref
                            // //     .watch(todoControllerProvider.notifier)
                            //     .typeCount);
                            final userTodo =
                                todos.getRight().fold(() => null, (todo) {
                              return todo;
                            });
                            return Container(
                              padding: const EdgeInsets.all(25),
                              margin: const EdgeInsets.only(
                                  bottom: 60, right: 30, left: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xffD9D9D9),
                                    Color.fromARGB(255, 110, 105, 105),
                                  ],
                                ),
                              ),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        userTodo![typeIndex].type.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 22),
                                      ),
                                      const Icon(
                                        Icons.play_arrow,
                                        size: 30,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 40),
                                  ListView.builder(
                                    itemCount:
                                        valueCount! >= 3 ? 3 : valueCount,
                                    // NOTE this shrinkWrap prevents the error of layout
                                    shrinkWrap: true,
                                    // NOTE this physics can allow to scroll the screen property
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, valueIndex) {
                                      final period = userTodo[typeIndex]
                                          .values![valueIndex]
                                          .period;
                                      final widget = Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Text(
                                          '{\n  "title": "${userTodo[typeIndex].values![valueIndex].title}",\n  "due date": "${period!.year}/${period.month}/${period.day}"\n}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: Colors.black),
                                          // overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                      return widget;
                                    },
                                  ),
                                  const SizedBox(height: 40),
                                ],
                              ),
                            );
                          },
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

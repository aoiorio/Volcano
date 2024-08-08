import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:volcano/gen/assets.gen.dart';
import 'package:volcano/presentation/component/global/bounced_button.dart';
import 'package:volcano/presentation/provider/front/todo/record_voice/record_voice_with_wave.dart';
import 'package:volcano/presentation/provider/front/todo/voice_recognition/voice_recognition_controller.dart';
import 'package:volcano/presentation/provider/front/tutorial/providers.dart';
import 'package:volcano/presentation/provider/global/is_done_tutorial.dart';

enum TutorialStatus {
  notYet,
  doing,
}

class TutorialPage extends HookConsumerWidget {
  const TutorialPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tutorialStatus = ref.watch(tutorialStatusProvider);
    final speechToText = SpeechToText();

    useEffect(
      () {
        speechToText.initialize();
        return;
      },
      [],
    );

    return Center(
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 2 + 50,
                width: MediaQuery.of(context).size.width / 2 + 100,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffD7D7D7),
                      Color(0xffAAA9AF),
                    ],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      '"Let\'s practice\nadding TODO 🍭"',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                    ),
                    const Spacer(),
                    tutorialStatus == TutorialStatus.notYet
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 80,
                            child: Assets.images.volcanoLogo.image(),
                          )
                        : AudioWaveforms(
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
                          ),
                    const Spacer(),
                    // LINK - https://pub.dev/packages/substring_highlight use this to add highlight
                    Text(
                      'Please say\n"title make a cake"\nto add a title',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 200,
                      height: 75,
                      child: BouncedButton(
                        onPress: () {
                          if (tutorialStatus == TutorialStatus.notYet) {
                            ref
                                .read(
                                  recordVoiceWithWaveControllerProvider
                                      .notifier,
                                )
                                .startRecordingWithWave();
                            ref
                                .read(
                                  voiceRecognitionControllerProvider(
                                    speechToText,
                                  ).notifier,
                                )
                                .recognizeVoice(speechToText);
                            ref
                                .read(
                                  tutorialStatusProvider.notifier,
                                )
                                .state = TutorialStatus.doing;
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ref
                                    .watch(
                                      voiceRecognitionControllerProvider(
                                        speechToText,
                                      ),
                                    )
                                    .toLowerCase()
                                    .contains(
                                      'title make a cake',
                                    )
                                ? const Color(0xff4C4C4C)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: tutorialStatus == TutorialStatus.notYet
                              ? Text(
                                  '"Start"',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                )
                              : ref
                                      .watch(
                                        voiceRecognitionControllerProvider(
                                          speechToText,
                                        ),
                                      )
                                      .toLowerCase()
                                      .contains(
                                        'title make a cake',
                                      )
                                  ? const Icon(
                                      Icons.check,
                                      color: Color(0xff8EA493),
                                      size: 30,
                                    )
                                  : const SpinKitPouringHourGlass(
                                      color: Color(0xff4C4C4C),
                                      size: 30,
                                    ),
                        ),
                      ),
                    ),
                    const Gap(20),
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(isDoneTutorialProvider.notifier)
                            .changeIsDoneTutorial();
                        ref
                            .read(
                              recordVoiceWithWaveControllerProvider.notifier,
                            )
                            .stopRecordingWithWave();
                        ref
                            .read(
                              voiceRecognitionControllerProvider(speechToText)
                                  .notifier,
                            )
                            .stopRecognizing(speechToText);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Skip',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.black),
                          ),
                          const Gap(10),
                          const Icon(
                            Icons.bedtime_rounded,
                            color: Color(0xff4C4C4C),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

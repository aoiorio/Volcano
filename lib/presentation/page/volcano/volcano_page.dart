import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:record/record.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:volcano/presentation/importer/volcano_page_importer.dart';
import 'package:volcano/presentation/page/dialogs/to_sign_up_dialog.dart';
import 'package:volcano/presentation/page/tutorial/tutorial_page.dart';
import 'package:volcano/presentation/provider/back/auth/shared_preference.dart';
import 'package:volcano/presentation/provider/global/is_done_tutorial.dart';

final isPushedVoiceButtonProvider = StateProvider<bool>((ref) {
  return false;
});

class VolcanoPage extends StatefulHookConsumerWidget {
  const VolcanoPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VolcanoPageState();
}

class _VolcanoPageState extends ConsumerState<VolcanoPage> {
  final recorder = AudioRecorder();
  final FToast toast = FToast();
  final player = AudioPlayer();
  final pageController = PageController(viewportFraction: 0.8);

  RecorderController recorderController = RecorderController();

  @override
  void dispose() {
    super.dispose();
    recorder.dispose();
    recorderController.dispose();
    player.dispose();
  }

  @override
  void initState() {
    super.initState();
    toast.init(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(todoControllerProvider.notifier).executeReadTodo();

      // NOTE to get color codes of todo cards
      ref
          .read(typeColorCodeControllerProvider.notifier)
          .executeReadTypeColorCode();

      // NOTE getting goal percentage such as 29.2, 98.9
      ref
          .read(goalInfoGetterProvider.notifier)
          .executeGetGoalInfo(toast: toast);
    });
  }

  @override
  Widget build(BuildContext context) {
    final speechToText = SpeechToText();

    // NOTE riverpod providers
    final todos = ref.watch(todoControllerProvider);
    final isListening =
        ref.watch(voiceRecognitionIsListeningControllerProvider);
    final recognizedText =
        ref.watch(voiceRecognitionControllerProvider(speechToText));
    final voiceRecognitionControllerNotifier =
        ref.watch(voiceRecognitionControllerProvider(speechToText).notifier);
    final goalInfo = ref.watch(goalInfoGetterProvider);
    final isPushedVoiceButton = ref.watch(isPushedVoiceButtonProvider);
    final accessToken = ref.watch(authSharedPreferenceProvider);

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(
            highlightColor: Colors.transparent,
            icon: const Icon(Icons.face, size: 35, color: Color(0xff4C4C4C)),
            onPressed: () {
              if (accessToken.isEmpty) {
                showToSignUpDialog(context);
                return;
              }
              // DONE show UserDialog
              showBarModalBottomSheet<void>(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                context: context,
                builder: (context) {
                  return const UserModal();
                },
              );
            },
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: PopScope(
        canPop: false,
        child: SingleChildScrollView(
          // NOTE if the user pushed the add-todo-from-voice button for the first time and hasn't done with the tutorial, we will show tutorial page
          physics: !ref.watch(isDoneTutorialProvider) && isPushedVoiceButton
              ? const NeverScrollableScrollPhysics()
              : const ScrollPhysics(),
          child: Center(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Opacity(
                  opacity:
                      !ref.watch(isDoneTutorialProvider) && !isPushedVoiceButton
                          ? 1
                          : ref.watch(isDoneTutorialProvider)
                              ? 1
                              : 0.6,
                  child: width >= 800
                      ? ClipPath(
                          clipper: OvalBottomBorderClipper(),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 2,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xffEEE3E1), Color(0xffC6C3C3)],
                              ),
                            ),
                          ),
                        )
                      : Assets.images.volcanoPageShape.svg(),
                ),
                Opacity(
                  opacity:
                      !ref.watch(isDoneTutorialProvider) && !isPushedVoiceButton
                          ? 1
                          : ref.watch(isDoneTutorialProvider)
                              ? 1
                              : 0.6,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 90),
                        child: Assets.images.volcanoLogo.image(width: 180),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: SizedBox(
                          width: width >= 800 ? width / 2 : width * 0.8, // 320,
                          height: 300,
                          child: BouncedButton(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                  colors: [
                                    isListening
                                        ? const Color(0xff7C7D8D)
                                        : const Color(0xff9596AE),
                                    isListening
                                        ? const Color(0xffB5A6A6)
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
                                              width / 2,
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
                              if (accessToken.isEmpty) {
                                showToSignUpDialog(context);
                                return;
                              }
                              // NOTE if user is not done with tutorial and has never pushed voice button, I'll show you tutorial dialog
                              if (!isPushedVoiceButton &&
                                  !ref.read(isDoneTutorialProvider)) {
                                ref
                                    .read(isPushedVoiceButtonProvider.notifier)
                                    .state = true;
                                return;
                              }
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
                      const Gap(50),
                      SizedBox(
                        width: width >= 800 ? width / 2 : width * 0.85, // 340
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
                            if (accessToken.isEmpty) {
                              showToSignUpDialog(context);
                              return;
                            }
                            // DONE implement add todo from text feature! (go to AddTodoPage)
                            showAddTodoDialog(context, isAddingFromText: true);
                          },
                        ),
                      ),
                      // DONE add shimmer effects
                      accessToken.isEmpty
                          ? const SizedBox()
                          : goalInfo.isLeft()
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(
                                    bottom: 20,
                                    right: 20,
                                    left: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 50),
                                        child: ShimmerWidget(
                                          width: width >= 800
                                              ? width / 2
                                              : width * 0.86,
                                          height: 220,
                                          radius: 30,
                                        ),
                                      ),
                                      const Gap(20),
                                      Container(
                                        margin: const EdgeInsets.only(top: 50),
                                        child: ShimmerWidget(
                                          width: width >= 800
                                              ? width / 2
                                              : width * 0.86,
                                          height: 220,
                                          radius: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Column(
                                  children: [
                                    SingleChildScrollView(
                                      controller: pageController,
                                      padding: const EdgeInsets.only(
                                        bottom: 20,
                                        right: 20,
                                        left: 20,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          GoalInfoCard(
                                            goalString: "Today's Goal",
                                            goalPercentage:
                                                goalInfo.getRight().fold(
                                                      () => 0.0,
                                                      (goalInfoObject) =>
                                                          goalInfoObject
                                                              .todayGoal!
                                                              .todayGoalPercentage ??
                                                          0.0,
                                                    ),
                                            onPressed: () {
                                              // DONE go to today's todo page
                                              goalInfo.getRight().fold(
                                                  () => null, (goalInfoObject) {
                                                context.push(
                                                  '/goal-todo-details',
                                                  extra: GoalType.today,
                                                );
                                              });
                                            },
                                            cardColorCode: 0xffAEADB9,
                                          ),
                                          const SizedBox(width: 20),
                                          GoalInfoCard(
                                            goalString: "Month's Goal",
                                            goalPercentage:
                                                goalInfo.getRight().fold(
                                                      () => 0.0,
                                                      (goalInfoObject) =>
                                                          goalInfoObject
                                                              .monthGoal!
                                                              .monthGoalPercentage ??
                                                          0.0,
                                                    ),
                                            onPressed: () {
                                              // DONE go to month's todo page
                                              goalInfo.getRight().fold(
                                                  () => null, (goalInfoObject) {
                                                context.push(
                                                  '/goal-todo-details',
                                                  extra: GoalType.month,
                                                );
                                              });
                                            },
                                            cardColorCode: 0xffBCBCB4,
                                          ),
                                        ],
                                      ),
                                    ),
                                    width >= 800
                                        ? const SizedBox()
                                        : SmoothPageIndicator(
                                            controller: pageController,
                                            count: 2,
                                            effect: const WormEffect(
                                              dotHeight: 8,
                                              dotWidth: 30,
                                              dotColor: Color(0xffD9D9d9),
                                              activeDotColor: Colors.black,
                                            ),
                                          ),
                                  ],
                                ),
                      const Gap(40),
                      accessToken.isEmpty
                          ? const SizedBox()
                          : todos.isLeft() ||
                                  ref
                                      .watch(typeColorCodeControllerProvider)
                                      .isLeft()
                              // DONE add shimmer effect here!!
                              ? Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(30),
                                      child: ShimmerWidget(
                                        width: width,
                                        height: 500,
                                        radius: 30,
                                      ),
                                    ),
                                    const Gap(30),
                                    Container(
                                      padding: const EdgeInsets.all(30),
                                      child: ShimmerWidget(
                                        width: width,
                                        height: 500,
                                        radius: 30,
                                      ),
                                    ),
                                  ],
                                )
                              : MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView.builder(
                                    itemCount: ref
                                        .watch(todoControllerProvider.notifier)
                                        .typeCount,
                                    // NOTE this shrinkWrap prevents the error of layout
                                    shrinkWrap: true,
                                    // NOTE this physics can allow to scroll the screen property
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, typeIndex) {
                                      final userTodo = todos
                                          .getRight()
                                          .fold(() => null, (todo) {
                                        return todo;
                                      });
                                      final playList = ref.watch(
                                        playListProvider(
                                          userTodo![typeIndex].type ?? '',
                                        ),
                                      );
                                      final audioSource =
                                          ConcatenatingAudioSource(
                                        // NOTE Specify the playlist items
                                        children: playList
                                            .map(
                                              (e) => LockCachingAudioSource(
                                                Uri.parse(
                                                  e,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      );
                                      // NOTE this is how to create hex color code by using the value from db
                                      final typeColorCodeObject = ref
                                          .watch(
                                            typeColorCodeControllerProvider
                                                .notifier,
                                          )
                                          .findTypeFromColorList(
                                            userTodo[typeIndex].type ?? '',
                                          );
                                      return TodoListCard(
                                        startColorCode: int.parse(
                                          typeColorCodeObject.startColorCode,
                                        ),
                                        endColorCode: int.parse(
                                          typeColorCodeObject.endColorCode,
                                        ),
                                        readTodoList: userTodo[typeIndex],
                                        audioSource: audioSource,
                                      );
                                    },
                                  ),
                                ),
                    ],
                  ),
                ),
                !ref.watch(isDoneTutorialProvider) && isPushedVoiceButton
                    ? const TutorialPage()
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

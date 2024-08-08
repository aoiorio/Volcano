import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:volcano/presentation/page/auth/sign_up_page.dart';
import 'package:volcano/presentation/page/tutorial/tutorial_page.dart';
import 'package:volcano/presentation/page/volcano/volcano_page.dart';
import 'package:volcano/presentation/provider/back/auth/shared_preference.dart';
import 'package:volcano/presentation/provider/global/is_done_tutorial.dart';

class StartPage extends HookConsumerWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // NOTE confirm that the user is Signed in or not now
    final authSharedPreference = ref.watch(authSharedPreferenceProvider);
    // ref.watch(isDoneTutorialProvider.notifier).deleteIsDoneTutorial();

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: authSharedPreference.isEmpty
            ? const SignUpPage()
            : Stack(
                children: [
                  Opacity(
                    opacity: ref.watch(isDoneTutorialProvider) ? 1 : 0.6,
                    child: const VolcanoPage(),
                  ),
                  // TODO move tutoiral page to volcano page, when users tap the add todo from voice button we can suggest the tutorial
                  !ref.watch(isDoneTutorialProvider)
                      ? const TutorialPage()
                      : const SizedBox(),
                ],
              ),
      ),
    );
  }
}

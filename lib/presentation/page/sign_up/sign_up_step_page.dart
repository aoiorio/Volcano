import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:volcano/presentation/component/bounced_button.dart';
import 'package:volcano/presentation/component/sign_up/sign_up_text_shape.dart';
import 'package:volcano/presentation/provider/front/sign_up/sign_up_page_providers.dart';

// TODOImplement my own step by step feature by using List on so on.
class SignUpStepPage extends ConsumerWidget {
  const SignUpStepPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ! DO NOT USE ref.watch(stepCounterProvider.notifier).state; because it won't work
    final stepCount = ref.watch(stepCounterProvider);

    final stepPages = <Widget>[
      const SignUpTextShape(
        gradientColorBegin: Color(0xff756980),
        gradientColorEnd: Color(0xffBDAEAE),
        stepTitle: '{\n   "1": \n   "type email"\n}',
        hintString: '"type email"',
        // textEditingController: emailTextController,
      ),
      const SignUpTextShape(
        gradientColorBegin: Color(0xffB09C93),
        gradientColorEnd: Color(0xffBDAEAE),
        stepTitle: '{\n   "2": \n   "type password"\n}',
        hintString: '"type password"',
        // textEditingController: passwordTextController,
      ),
      const SignUpTextShape(
        gradientColorBegin: Color(0xff8A8E7C),
        gradientColorEnd: Color(0xffBDAEAE),
        stepTitle: '{\n   "3": \n   "type confirm PW"\n}',
        hintString: '"type confirm PW"',
        // textEditingController: confirmPasswordTextController,
      ),
    ];

    return Scaffold(
      //LINK - Please Write Notion about resizeToAvoidBottomInset
      // NOTE it means that when I show up keyboard, the widgets won't move
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,

        leadingWidth: 80,
        // NOTE Back button
        leading: SizedBox(
          width: 50,
          height: 50,
          child: BouncedButton(
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back),
            ),
            onPress: () {
              HapticFeedback.lightImpact();
              context.pop(true);
            },
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xffD7D7D7),
      body: GestureDetector(
        onTap: () {
          primaryFocus?.unfocus();
        },
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    ref.watch(stepCounterProvider.notifier).state = 0;
                  },
                  child: Column(
                    children: [
                      const Text('{1}'),
                      // NOTE add arrow when user is in the email field page
                      stepCount == 0
                          ? const Icon(
                              Icons.arrow_upward_outlined,
                              size: 30,
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                const SizedBox(width: 60),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    ref.watch(stepCounterProvider.notifier).state = 1;
                  },
                  child: Column(
                    children: [
                      const Text('{2}'),
                      stepCount == 1
                          ? const Icon(
                              Icons.arrow_upward_outlined,
                              size: 30,
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                const SizedBox(width: 60),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    ref.watch(stepCounterProvider.notifier).state = 2;
                  },
                  child: Column(
                    children: [
                      const Text('{3}'),
                      stepCount == 2
                          ? const Icon(
                              Icons.arrow_upward_outlined,
                              size: 30,
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
            // NOTE show page
            stepPages[stepCount],
          ],
        ),
      ),
    );
  }
}

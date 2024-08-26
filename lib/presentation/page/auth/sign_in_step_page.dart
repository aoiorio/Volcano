import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:volcano/presentation/component/global/bounced_button.dart';
import 'package:volcano/presentation/component/sign_in/sign_in_step_shape.dart';
import 'package:volcano/presentation/component/sign_up/sign_up_step_shape.dart';

import 'package:volcano/presentation/provider/front/auth/sign_in_providers.dart';

// DONE Implement my own step by step feature by using List on so on.
class SignInStepPage extends ConsumerWidget {
  const SignInStepPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepCount = ref.watch(signInStepCounterProvider);

    final stepPages = <Widget>[
      SignInStepShape(
        gradientColorBegin: const Color(0xff484A5A).withOpacity(0.85),
        gradientColorEnd: const Color(0xffBDAEAE),
        stepTitle: '{\n   "1": \n   "type email"\n}',
        hintString: 'type email here...',
        textEditingControllerType: TextEditingControllerType.email,
      ),
      SignInStepShape(
        gradientColorBegin: const Color(0xff5E4A49).withOpacity(0.85),
        gradientColorEnd: const Color(0xffBDAEAE),
        stepTitle: '{\n   "2": \n   "type password"\n}',
        hintString: 'type password here...',
        textEditingControllerType: TextEditingControllerType.password,
      ),
    ];
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
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
            SizedBox(
              height: width >= 800 && width <= 850 ? height * 0.15 : 150,
            ), // 150
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    ref.watch(signInStepCounterProvider.notifier).state = 0;
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
                    ref.watch(signInStepCounterProvider.notifier).state = 1;
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
              ],
            ),
            SizedBox(
              height: width >= 800 && width <= 850 ? height * 0.15 : 80,
            ),
            // NOTE show page
            stepPages[stepCount],
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:volcano/presentation/component/global/bounced_button.dart';
import 'package:volcano/presentation/component/sign_up/sign_up_step_shape.dart';
import 'package:volcano/presentation/provider/front/auth/sign_up_providers.dart';

// TODOImplement my own step by step feature by using List on so on.
class SignUpStepPage extends ConsumerWidget {
  const SignUpStepPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ! DO NOT USE ref.watch(signUpStepCounterProvider.notifier).state; because it won't work
    final stepCount = ref.watch(signUpStepCounterProvider);

    final stepPages = <Widget>[
      const SignUpStepShape(
        gradientColorBegin: Color(0xff756980),
        gradientColorEnd: Color(0xffBDAEAE),
        stepTitle: '{\n   "1": \n   "type email"\n}',
        hintString: 'type email here...',
        textEditingControllerType: TextEditingControllerType.email,
        // textEditingController: emailTextController,
      ),
      const SignUpStepShape(
        gradientColorBegin: Color(0xffB09C93),
        gradientColorEnd: Color(0xffBDAEAE),
        stepTitle: '{\n   "2": \n   "type password"\n}',
        hintString: 'type password here...',
        textEditingControllerType: TextEditingControllerType.password,
        // textEditingController: passwordTextController,
      ),
      const SignUpStepShape(
        gradientColorBegin: Color(0xff8A8E7C),
        gradientColorEnd: Color(0xffBDAEAE),
        stepTitle: '{\n   "3": \n   "type confirm PW"\n}',
        hintString: 'type password again here...',
        textEditingControllerType: TextEditingControllerType.confirmPassword,
        // textEditingController: confirmPasswordTextController,
      ),
    ];

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      // NOTE it means that when I show up keyboard, the widgets won't move
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,

        leadingWidth: 80,
        // NOTE Back button
        leading: SizedBox(
          width: 50,
          height: 50,
          child: Container(
            margin: EdgeInsets.only(top: width <= 375 ? 10 : 0),
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
              height:  width >= 800 && width <= 850 ? height * 0.15 : height * 0.18,
            ), // 150
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    ref.watch(signUpStepCounterProvider.notifier).state = 0;
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
                    ref.watch(signUpStepCounterProvider.notifier).state = 1;
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
                    ref.watch(signUpStepCounterProvider.notifier).state = 2;
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

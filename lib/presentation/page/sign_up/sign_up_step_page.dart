import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:volcano/presentation/component/bounced_button.dart';
import 'package:flutter/services.dart';
import 'package:volcano/presentation/component/sign_up_text_shape.dart';
import 'package:volcano/presentation/provider/sign_up_page_providers.dart';

// TODO Implement my own step by step feature by using List on so on.
class SignUpStepPage extends ConsumerWidget {
  const SignUpStepPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailTextController = ref.watch(emailTextControllerProvider);
    final passwordTextController = ref.watch(passwordTextControllerProvider);
    final confirmPasswordTextController =
        ref.watch(confirmPasswordTextControllerProvider);

    final List<Widget> stepPages = [
      SignUpTextShape(
        gradientColorBegin: Color(0xff756980),
        gradientColorEnd: Color(0xffBDAEAE),
        stepTitle: '{\n   "1": \n   "type email"\n}',
        hintString: '"email"',
        textEditingController: emailTextController,
      ),
      SignUpTextShape(
        gradientColorBegin: Color(0xffB09C93),
        gradientColorEnd: Color(0xffBDAEAE),
        stepTitle: '{\n   "1": \n   "type password"\n}',
        hintString: '"password"',
        textEditingController: passwordTextController,
      ),
      SignUpTextShape(
        gradientColorBegin: Color(0xff8A8E7C),
        gradientColorEnd: Color(0xffBDAEAE),
        stepTitle: '{\n   "1": \n   "type confirm PW"\n}',
        hintString: '"confirm PW"',
        textEditingController: confirmPasswordTextController,
      ),
    ];
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
            const SizedBox(
              height: 150,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text('{1}'),
                  ],
                ),
                SizedBox(width: 60),
                Column(
                  children: [
                    Text('{2}'),
                  ],
                ),
                SizedBox(width: 60),
                Column(
                  children: [
                    Text('{3}'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 80),
            stepPages[0]
          ],
        ),
      ),
    );
  }
}

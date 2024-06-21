import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:volcano/presentation/component/global/bounced_button.dart';
import 'package:volcano/presentation/component/global/custom_toast.dart';
import 'package:volcano/presentation/component/global/white_main_button.dart';
import 'package:volcano/presentation/component/sign_in/sign_in_shape_button.dart';
import 'package:volcano/presentation/provider/back/auth/controller/sign_in_controller.dart';
import 'package:volcano/presentation/provider/front/sign_in/sign_in_page_providers.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final toast = FToast();
  @override
  Widget build(BuildContext context) {
    final signInEmailStatus = ref.watch(signInEmailStatusProvider) ? 'OK' : '';
    final signInPasswordStatus =
        ref.watch(signInPasswordStatusProvider) ? 'OK' : '';
    return Scaffold(
      backgroundColor: const Color(0xffD7D7D7),
      extendBodyBehindAppBar: true,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 120),
          const Center(
            child: Image(
              image: AssetImage('assets/images/volcano_logo.png'),
              width: 250,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff484A5A),
                        Color(0xff827979),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff484A5A),
                        Color(0xff827979),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff484A5A),
                        Color(0xff827979),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    ref.watch(signInStepCounterProvider.notifier).state = 0;
                    // context.go('/sign-in-step');
                    context.push('/sign-in-step').then((value) {
                      setState(() {});
                    });
                  },
                  child: SignInShapeButton(
                    gradientColorBegin:
                        const Color(0xff484A5A).withOpacity(0.75),
                    gradientColorEnd: const Color(0xffBDAEAE),
                    // DONE Add status provider here like this {"Email": ${signUpPasswordStatusProvider.read()}}
                    fieldString: '{"Email": "$signInEmailStatus"}',
                  ),
                ),
                Positioned(
                  top: 130,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      ref.watch(signInStepCounterProvider.notifier).state = 1;
                      context.push('/sign-in-step').then((value) {
                        setState(() {});
                      });
                    },
                    child: SignInShapeButton(
                      gradientColorBegin:
                          const Color(0xff5E4A49).withOpacity(0.45),
                      gradientColorEnd: const Color(0xffBDAEAE),
                      // DONE Add status provider here like this {"Email": ${signUpConfirmPasswordStatusProvider.read()}}
                      fieldString: '{"Password": "$signInPasswordStatus"}',
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  child: WhiteMainButton(
                    onPress: () async {
                      HapticFeedback.mediumImpact();
                      if (signInEmailStatus.isEmpty) {
                        showToastMessage(
                          toast,
                          'Email must have at least \n 3 characters and contain @',
                          ToastWidgetKind.error,
                        );
                        return;
                      } else if (signInPasswordStatus.isEmpty) {
                        showToastMessage(
                          toast,
                          'Password must have \n at least 4 characters',
                          ToastWidgetKind.error,
                        );
                        return;
                      }

                      ref
                          .watch(authExecuteSignInControllerProvider.notifier)
                          .executeSignIn(toast, context);
                    },
                    title: '"Submit"',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

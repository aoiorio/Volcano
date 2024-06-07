import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:volcano/presentation/component/bounced_button.dart';
import 'package:volcano/presentation/component/sign_up/sign_up_main_button.dart';
import 'package:volcano/presentation/component/sign_up/sign_up_shape_button.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:volcano/presentation/provider/back/auth/auth_providers.dart';
import 'package:volcano/presentation/provider/front/sign_up/sign_up_page_providers.dart';

// TODO Implement SignUp features!
class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    // NOTE my providers!
    final emailStatus = ref.watch(emailStatusProvider) ? "OK" : "";
    final passwordStatus = ref.watch(passwordStatusProvider) ? "OK" : "";
    final confirmPasswordStatus =
        ref.watch(confirmPasswordStatusProvider) ? "OK" : "";
    final authUseCase = ref.read(authUseCaseProvider);
    final isLoading = ref.watch(isSignUpLoadingProvider);

    return Scaffold(
      backgroundColor: const Color(0xffD7D7D7),
      body: isLoading
          ? const CircularProgressIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 120),
                const Center(
                  child: Image(
                    image: AssetImage("assets/images/volcano_logo.png"),
                    width: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 70),
                Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          // NOTE change stepCounter
                          ref.watch(stepCounterProvider.notifier).state = 0;

                          // NOTE go to SignUpEmailPage and to change the text of fields, I'm adding then function.
                          context.push('/sign-up-step').then((value) {
                            setState(() {});
                          });
                          print('This is email field');
                        },
                        child: SignUpShapeButton(
                          gradientColorBegin: const Color(0xff756980),
                          gradientColorEnd: const Color(0xffBDAEAE),
                          // DONE Add status provider here like this {"Email": ${StatusProvider.read()}}
                          fieldString: '{"Email": "$emailStatus"}',
                        ),
                      ),
                      Positioned(
                        top: 130,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            ref.watch(stepCounterProvider.notifier).state = 1;
                            context.push('/sign-up-step').then((value) {
                              setState(() {});
                            });
                            print('This is password field');
                          },
                          child: SignUpShapeButton(
                            gradientColorBegin: const Color(0xffB09C93),
                            gradientColorEnd: const Color(0xffBDAEAE),
                            // DONE Add status provider here like this {"Email": ${PasswordStatusProvider.read()}}
                            fieldString: '{"Password": "$passwordStatus"}',
                          ),
                        ),
                      ),
                      Positioned(
                        top: 260,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            ref.watch(stepCounterProvider.notifier).state = 2;
                            context.push('/sign-up-step').then((value) {
                              setState(() {});
                            });
                            print('This is Confirm PW field');
                          },
                          child: SignUpShapeButton(
                            gradientColorBegin: const Color(0xff8A8E7C),
                            gradientColorEnd: const Color(0xffBDAEAE),
                            // DONE Add status provider here like this {"Email": ${ConfirmPasswordStatusProvider.read()}}
                            fieldString:
                                '{"Confirm PW": "$confirmPasswordStatus"}',
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 100,
                        child: SignUpMainButton(
                          onPress: () async {
                            HapticFeedback.mediumImpact();
                            // DONE Create API Endpoints for signing up!!!
                            // NOTE I should create provider for this method (SignUp method) with validation!!!!!
                            if (emailStatus.isEmpty) {
                              showMessage(
                                  'Email must be at least 3 characters and contain @');
                              return;
                            }
                            ref.read(isSignUpLoadingProvider.notifier).state =
                                true;
                            final signUpResult = await authUseCase.executeSignUp(
                                email:
                                    ref.read(emailTextControllerProvider).text,
                                password: ref
                                    .read(passwordTextControllerProvider)
                                    .text,
                                confirmPassword: ref
                                    .read(confirmPasswordTextControllerProvider)
                                    .text);

                            // TODO implement flutter toast!!! pop up here!!!
                            if (signUpResult.isRight()) {
                              if (!context.mounted) return;
                              context.push('/volcano');
                              ref.read(isSignUpLoadingProvider.notifier).state =
                                  false;
                            } else if (signUpResult.isLeft()) {
                              signUpResult.getLeft().fold(
                                  () => null,
                                  (error) =>
                                      print(error.message?.detail ?? ""));
                            }
                            ref.read(isSignUpLoadingProvider.notifier).state =
                                false;
                          },
                          title: '"Submit"',
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        child: BouncedButton(
                          child: Row(
                            children: [
                              Text(
                                '"Sign In"',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: const Color(0xff343434)),
                              ),
                              const SizedBox(width: 10),
                              const Icon(Icons.arrow_forward)
                            ],
                          ),
                          onPress: () {
                            // TODO Go to SignInPage
                            print('Hi SignIn');
                          },
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

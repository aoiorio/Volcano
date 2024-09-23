import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:volcano/gen/assets.gen.dart';
import 'package:volcano/presentation/component/global/bounced_button.dart';
import 'package:volcano/presentation/component/global/custom_toast.dart';
import 'package:volcano/presentation/component/global/white_main_button.dart';
import 'package:volcano/presentation/component/sign_up/sign_up_shape_button.dart';
import 'package:volcano/presentation/component/sign_up/sign_up_step_shape.dart';
import 'package:volcano/presentation/provider/back/auth/controller/sign_up_controller.dart';
import 'package:volcano/presentation/provider/front/auth/sign_up_providers.dart';

GlobalKey navigatorKey = GlobalKey();

// DONE Implement SignUp features!
class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final toast = FToast();
  final player = AudioPlayer(); // Create a player

  @override
  void initState() {
    toast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // NOTE my providers!
    final emailStatus = ref.watch(signUpEmailStatusProvider) ? 'OK' : '';
    final passwordStatus = ref.watch(signUpPasswordStatusProvider) ? 'OK' : '';
    final confirmPasswordStatus =
        ref.watch(signUpConfirmPasswordStatusProvider) ? 'OK' : '';
    final authExecuteSignUpMethodsControllerNotifier =
        ref.watch(authExecuteSignUpControllerProvider.notifier);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xffD7D7D7),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: width >= 380 ? height * 0.15 : height * 0.05,
              // height: width >= 800 && width <= 850 ? height * 0.15 : 120,
            ),
            Center(
              child: Assets.images.volcanoLogo
                  .image(width: width <= 375 ? 200 : 250),
            ),
            SizedBox(
              height:
                  width >= 800 && width <= 850 ? height * 0.1 : height * 0.06,
            ),
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      // NOTE change stepCounter
                      ref.watch(signUpStepCounterProvider.notifier).state = 0;

                      // NOTE go to SignUpEmailPage and to change the text of fields, I'm adding then function.
                      context.push('/sign-up-step').then((value) {
                        setState(() {});
                      });
                    },
                    child: SignUpShapeButton(
                      gradientColorBegin: const Color(0xff756980),
                      gradientColorEnd: const Color(0xffBDAEAE),
                      // DONE Add status provider here like this {"Email": ${StatusProvider.read()}}
                      fieldString: '{"Email": "$emailStatus"}',
                      textEditingControllerType:
                          TextEditingControllerType.email,
                    ),
                  ),
                  Positioned(
                    top: 130,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        ref.watch(signUpStepCounterProvider.notifier).state = 1;
                        context.push('/sign-up-step').then((value) {
                          setState(() {});
                        });
                      },
                      child: SignUpShapeButton(
                        gradientColorBegin: const Color(0xffB09C93),
                        gradientColorEnd: const Color(0xffBDAEAE),
                        // DONE Add status provider here like this {"Email": ${signUpPasswordStatusProvider.read()}}
                        fieldString: '{"Password": "$passwordStatus"}',
                        textEditingControllerType:
                            TextEditingControllerType.password,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 260,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        ref.watch(signUpStepCounterProvider.notifier).state = 2;
                        context.push('/sign-up-step').then((value) {
                          setState(() {});
                        });
                      },
                      child: SignUpShapeButton(
                        gradientColorBegin: const Color(0xff8A8E7C),
                        gradientColorEnd: const Color(0xffBDAEAE),
                        // DONE Add status provider here like this {"Email": ${signUpConfirmPasswordStatusProvider.read()}}
                        fieldString: '{"Confirm PW": "$confirmPasswordStatus"}',
                        textEditingControllerType:
                            TextEditingControllerType.confirmPassword,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: width >= 800 && width <= 850
                        ? height * 0.17
                        : height * 0.12,
                    child: WhiteMainButton(
                      onPress: () async {
                        HapticFeedback.mediumImpact();

                        // DONE Create API Endpoints for signing up!!!
                        // NOTE I should create provider for this method (SignUp method) with validation!!!!!
                        // NOTE validation and show Toasts!
                        if (emailStatus.isEmpty) {
                          showToastMessage(
                            toast,
                            'Email must have at least \n 3 characters and contain @',
                            ToastWidgetKind.error,
                          );
                          return;
                        } else if (passwordStatus.isEmpty) {
                          showToastMessage(
                            toast,
                            'Password must have \n at least 4 characters',
                            ToastWidgetKind.error,
                          );
                          return;
                        } else if (confirmPasswordStatus.isEmpty) {
                          showToastMessage(
                            toast,
                            'Confirm PW must be \n same as password',
                            ToastWidgetKind.error,
                          );
                          return;
                        }

                        authExecuteSignUpMethodsControllerNotifier
                            .executeSignUp(toast, context);
                      },
                      // title: '"Submit"',
                      titleWidget: Text(
                        '"Submit"',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 20,
                              color: const Color(0xff343434),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: width >= 800 && width <= 850
                        ? height * 0.12
                        : height * 0.07, // 50
                    child: BouncedButton(
                      child: Row(
                        children: [
                          Text(
                            '"Sign In"',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: const Color(0xff343434),
                                    ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.arrow_forward),
                        ],
                      ),
                      onPress: () {
                        // DONE Go to SignInPage
                        context.push('/sign-in');
                        debugPrint('Hi SignIn');
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    child: Row(
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            elevation: MaterialStateProperty.all(0),
                            splashFactory: NoSplash.splashFactory,
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: const Text(
                            'Privacy Policy',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            final url = Uri.parse(
                              'https://docs.google.com/document/d/1uKpCKA9RL0uzrGP-rYF73r-5aEzHC5CwDuHY6lPz6HI/edit?usp=sharing',
                            );
                            launchUrl(url);
                          },
                        ),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            elevation: MaterialStateProperty.all(0),
                            splashFactory: NoSplash.splashFactory,
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: const Text(
                            'Terms of Service',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            final url = Uri.parse(
                              'https://docs.google.com/document/d/1rk6X3S28Ipwg5WGq69ESrUicFqL2biR0fcqXglfgcX0/edit?usp=sharing',
                            );
                            launchUrl(url);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

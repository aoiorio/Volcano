import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volcano/presentation/component/bounced_button.dart';
import 'package:volcano/presentation/component/sign_up_shape_button.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:volcano/presentation/provider/sign_up_page_providers.dart';

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
    final emailStatus =
        ref.watch(isEmailFilledProvider.notifier).state ? "OK" : "";
    final passwordStatus =
        ref.watch(isPasswordFilledProvider.notifier).state ? "OK" : "";
    final confirmPasswordStatus =
        ref.watch(isConfirmPasswordFilledProvider.notifier).state ? "OK" : "";
    return Scaffold(
      backgroundColor: const Color(0xffD7D7D7),
      body: Column(
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
                    // NOTE go to SignUpEmailPage and to change the text of fields, I'm adding then function.
                    context.push('/sign-up-email').then((value) {
                      setState(() {});
                    });
                    print('This is email field');
                  },
                  child: SignUpShapeButton(
                    gradientColorBegin: Color(0xff756980),
                    gradientColorEnd: Color(0xffBDAEAE),
                    // TODO Add status provider here like this {"Email": ${StatusProvider.read()}}
                    fieldString: '{"Email": "$emailStatus"}',
                  ),
                ),
                Positioned(
                  top: 130,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      print('This is password field');
                    },
                    child: SignUpShapeButton(
                      gradientColorBegin: Color(0xffB09C93),
                      gradientColorEnd: Color(0xffBDAEAE),
                      // TODO Add status provider here like this {"Email": ${PasswordStatusProvider.read()}}
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
                      print('This is Confirm PW field');
                    },
                    child: SignUpShapeButton(
                      gradientColorBegin: Color(0xff8A8E7C),
                      gradientColorEnd: Color(0xffBDAEAE),
                      // TODO Add status provider here like this {"Email": ${ConfirmPasswordStatusProvider.read()}}
                      fieldString: '{"Confirm PW": "$confirmPasswordStatus"}',
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  child: SizedBox(
                    width: 200,
                    height: 75,
                    child: BouncedButton(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          '"Submit"',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 20, color: const Color(0xff343434)),
                        ),
                      ),
                      onPress: () {
                        HapticFeedback.mediumImpact();
                        print('hi submit');
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 50,
                  child: BouncedButton(
                    child: Row(
                      children: [
                        Text(
                          '"Login"',
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
                      // TODO Go to LoginPage
                      print('Hi Login');
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

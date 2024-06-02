import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:volcano/presentation/component/bounced_button.dart';
import 'package:volcano/presentation/component/sign_up_shape_button.dart';
import 'package:flutter/services.dart';

// TODO Implement SignUp features!

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                const SignUpShapeButton(
                  gradientColorBegin: Color(0xff756980),
                  gradientColorEnd: Color(0xffBDAEAE),
                  // TODO Add status provider here like this {"Email": ${StatusProvider.read()}}
                  fieldString: '{"Email": ""}',
                ),
                const Positioned(
                  top: 130,
                  bottom: 0,
                  child: SignUpShapeButton(
                    gradientColorBegin: Color(0xffB09C93),
                    gradientColorEnd: Color(0xffBDAEAE),
                    // TODO Add status provider here like this {"Email": ${PasswordStatusProvider.read()}}
                    fieldString: '{"Password": ""}',
                  ),
                ),
                const Positioned(
                  top: 260,
                  bottom: 0,
                  child: SignUpShapeButton(
                    gradientColorBegin: Color(0xff8A8E7C),
                    gradientColorEnd: Color(0xffBDAEAE),
                    // TODO Add status provider here like this {"Email": ${ConfirmPasswordStatusProvider.read()}}
                    fieldString: '{"Confirm PW": ""}',
                  ),
                ),
                Positioned(
                  bottom: 90,
                  child: SizedBox(
                    width: 200,
                    height: 85,
                    child: BouncedButton(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: const Text('"Submit"'),
                      ),
                      onPress: () {
                        HapticFeedback.mediumImpact();
                        print('hi submit');
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 45,
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
                        // const SizedBox(width: 10),
                        // const Icon(Icons.arrow_forward)
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

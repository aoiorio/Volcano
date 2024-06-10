import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:volcano/presentation/component/bounced_button.dart';
import 'package:volcano/presentation/component/sign_up/sign_up_main_button.dart';
import 'package:volcano/presentation/component/sign_up/sign_up_shape_button.dart';

// class SignInPage extends ConsumerWidget {
//   const SignInPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       backgroundColor: const Color(0xffD7D7D7),
//       appBar: AppBar(
//         forceMaterialTransparency: true,

//         leadingWidth: 80,
//         // NOTE Back button
//         leading: SizedBox(
//           width: 50,
//           height: 50,
//           child: BouncedButton(
//             child: Container(
//               margin: const EdgeInsets.only(left: 20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: const Icon(Icons.arrow_back),
//             ),
//             onPress: () {
//               HapticFeedback.lightImpact();
//               context.pop(true);
//             },
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//       ),
//       // TODOImplement SignIn feature
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const SizedBox(height: 120),
//           const Center(
//             child: Image(
//               image: AssetImage('assets/images/volcano_logo.png'),
//               width: 250,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(height: 70),
//           Expanded(
//             child: Stack(
//               alignment: AlignmentDirectional.bottomCenter,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     HapticFeedback.lightImpact();
//                     // NOTE change stepCounter
//                     ref.watch(stepCounterProvider.notifier).state = 0;

//                     // NOTE go to SignUpEmailPage and to change the text of fields, I'm adding then function.
//                     context.push('/sign-up-step').then((value) {
//                       setState(() {});
//                     });
//                   },
//                   child: SignUpShapeButton(
//                     gradientColorBegin: const Color(0xff756980),
//                     gradientColorEnd: const Color(0xffBDAEAE),
//                     // DONE Add status provider here like this {"Email": ${StatusProvider.read()}}
//                     fieldString: '{"Email": "OK"}',
//                   ),
//                 ),
//                 Positioned(
//                   top: 130,
//                   bottom: 0,
//                   child: GestureDetector(
//                     onTap: () {
//                       HapticFeedback.lightImpact();
//                       // ref.watch(stepCounterProvider.notifier).state = 1;
//                       // context.push('/sign-up-step').then((value) {
//                       //   setState(() {});
//                       // });
//                     },
//                     child: SignUpShapeButton(
//                       gradientColorBegin: const Color(0xffB09C93),
//                       gradientColorEnd: const Color(0xffBDAEAE),
//                       // DONE Add status provider here like this {"Email": ${PasswordStatusProvider.read()}}
//                       fieldString: '{"Password": ""}',
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 260,
//                   bottom: 0,
//                   child: GestureDetector(
//                     onTap: () {
//                       HapticFeedback.lightImpact();
//                       // ref.watch(stepCounterProvider.notifier).state = 2;
//                       // context.push('/sign-up-step').then((value) {
//                       //   setState(() {});
//                       // });
//                     },
//                     child: SignUpShapeButton(
//                       gradientColorBegin: const Color(0xff8A8E7C),
//                       gradientColorEnd: const Color(0xffBDAEAE),
//                       // DONE Add status provider here like this {"Email": ${ConfirmPasswordStatusProvider.read()}}
//                       fieldString: '{"Confirm PW": ""}',
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 100,
//                   child: SignUpMainButton(
//                     onPress: () async {
//                       HapticFeedback.mediumImpact();
//                     },
//                     title: '"Submit"',
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 50,
//                   child: BouncedButton(
//                     child: Row(
//                       children: [
//                         Text(
//                           '"Sign In"',
//                           style:
//                               Theme.of(context).textTheme.bodySmall!.copyWith(
//                                     color: const Color(0xff343434),
//                                   ),
//                         ),
//                         const SizedBox(width: 10),
//                         const Icon(Icons.arrow_forward),
//                       ],
//                     ),
//                     onPress: () {
//                       // TODOGo to SignInPage
//                       context.push('/sign-in');
//                       debugPrint('Hi SignIn');
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  @override
  Widget build(BuildContext context) {
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
          // const SizedBox(height: 70),
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    // ref.watch(stepCounterProvider.notifier).state = 1;
                    // context.push('/sign-up-step').then((value) {
                    //   setState(() {});
                    // });
                  },
                  child: SignUpShapeButton(
                    gradientColorBegin:
                        const Color(0xff484A5A).withOpacity(0.85),
                    gradientColorEnd: const Color(0xffBDAEAE),
                    // DONE Add status provider here like this {"Email": ${PasswordStatusProvider.read()}}
                    fieldString: '{"Password": "OK"}',
                  ),
                ),
                Positioned(
                  top: 130,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      // ref.watch(stepCounterProvider.notifier).state = 2;
                      // context.push('/sign-up-step').then((value) {
                      //   setState(() {});
                      // });
                    },
                    child: SignUpShapeButton(
                      gradientColorBegin:
                          const Color(0xff5E4A49).withOpacity(0.55),
                      gradientColorEnd: const Color(0xffBDAEAE),
                      // DONE Add status provider here like this {"Email": ${ConfirmPasswordStatusProvider.read()}}
                      fieldString: '{"Confirm PW": ""}',
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  child: SignUpMainButton(
                    onPress: () async {
                      HapticFeedback.mediumImpact();
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:volcano/gen/assets.gen.dart';
import 'package:volcano/presentation/component/global/bounced_button.dart';
import 'package:volcano/presentation/component/global/custom_toast.dart';
import 'package:volcano/presentation/component/global/white_main_button.dart';
import 'package:volcano/presentation/component/sign_in/sign_in_shape_button.dart';
import 'package:volcano/presentation/provider/back/auth/controller/sign_in_controller.dart';
import 'package:volcano/presentation/provider/front/auth/sign_in_providers.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final toast = FToast();

  @override
  void initState() {
    super.initState();
    toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final signInEmailStatus = ref.watch(signInEmailStatusProvider) ? 'OK' : '';
    final signInPasswordStatus =
        ref.watch(signInPasswordStatusProvider) ? 'OK' : '';

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffD7D7D7),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        leadingWidth: 80,
        // NOTE Back button
        leading: Container(
          margin: EdgeInsets.only(top: width <= 375 ? 10 : 0),
          child: SizedBox(
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
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: width >= 380 ? height * 0.15 : height * 0.1,
          ),
          Center(
            child: Assets.images.volcanoLogo
                .image(width: width <= 375 ? 200 : 250),
          ),
          Padding(
            padding: EdgeInsets.all(
              width >= 800 && width <= 850 ? height * 0.1 : height * 0.1,
            ),
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
                  bottom: width >= 800 && width <= 850
                      ? height * 0.17
                      : width <= 375
                          ? height * 0.05
                          : height * 0.08,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

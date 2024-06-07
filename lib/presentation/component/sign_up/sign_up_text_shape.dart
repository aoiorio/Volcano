import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:volcano/presentation/component/sign_up/sign_up_main_button.dart';
import 'package:volcano/presentation/provider/front/sign_up/sign_up_page_providers.dart';

class SignUpTextShape extends ConsumerStatefulWidget {
  const SignUpTextShape({
    super.key,
    required this.gradientColorBegin,
    required this.gradientColorEnd,
    required this.stepTitle,
    required this.hintString,
  });

  final Color gradientColorBegin;
  final Color gradientColorEnd;
  final String stepTitle;
  final String hintString;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignUpTextShapeState();
}

class _SignUpTextShapeState extends ConsumerState<SignUpTextShape> {
  // @override
  // void initState() {
  //   if (ref.read(passwordTextControllerProvider).text ==
  //       ref.read(confirmPasswordTextControllerProvider).text) super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final textEditingController = ref
        .watch(signUpTextEditingControllerProvider(widget.hintString).notifier)
        .state;

    return Expanded(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SizedBox(
            width: width,
            height: height,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(100),
                ),
                gradient: LinearGradient(
                  colors: [widget.gradientColorBegin, widget.gradientColorEnd],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            child: Text(
              widget.stepTitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white),
            ),
          ),
          Positioned(
            // top: 20,
            child: SizedBox(
              width: 300,
              height: 90,
              child: TextField(
                controller: textEditingController,
                onChanged: (value) {
                  // NOTE Validations
                  // DONE - There's a bug of validation, if I changed password again after I inputted confirm PW and password then I got home, Confirm PW status will be OK. (it's not OK!!)
                  final emailText = ref.read(emailTextControllerProvider).text;
                  final passwordText =
                      ref.read(passwordTextControllerProvider).text;
                  final confirmPasswordText =
                      ref.read(confirmPasswordTextControllerProvider).text;
                  if (emailText.contains('@') && emailText.trim().length >= 3) {
                    ref.read(emailStatusProvider.notifier).state = true;
                  } else {
                    ref.read(emailStatusProvider.notifier).state = false;
                  }
                  if (passwordText.trim().length >= 4) {
                    ref.read(passwordStatusProvider.notifier).state = true;
                  } else {
                    ref.read(passwordStatusProvider.notifier).state = false;
                  }

                  if (confirmPasswordText.trim().length >= 4 &&
                      confirmPasswordText == passwordText) {
                    ref.read(confirmPasswordStatusProvider.notifier).state =
                        true;
                  } else {
                    ref.read(confirmPasswordStatusProvider.notifier).state =
                        false;
                  }
                },
                cursorColor: Colors.grey,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(30),
                  filled: true,
                  fillColor: const Color(0xff343434),
                  hintText: widget.hintString,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Color(0xff343434),
                    ),
                  ),
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned(
            top: 385,
            child: SignUpMainButton(
                title: widget.hintString.contains("confirm")
                    ? '"Finish"'
                    : '"Next"',
                onPress: () {
                  HapticFeedback.mediumImpact();
                  widget.hintString.contains("confirm")
                      ? context.pop()
                      : ref
                          .watch(stepCounterProvider.notifier)
                          .update((state) => state + 1);
                }),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:volcano/presentation/component/sign_up/sign_up_main_button.dart';
import 'package:volcano/presentation/provider/sign_up_page_providers.dart';

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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final textEditingController = ref
        .watch(signUpTextEditingControllerProvider(widget.hintString).notifier)
        .state;
    final passwordText =
        ref.watch(passwordTextControllerProvider.notifier).state.text;

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
                  if (!value.contains("@") &&
                      widget.hintString.contains("email")) {
                    ref.watch(isEmailFilledProvider.notifier).state = false;
                  } else if (widget.hintString.contains("email") &&
                      value.trim().isNotEmpty &&
                      value.length >= 3) {
                    ref.watch(isEmailFilledProvider.notifier).state = true;
                  }
                  if (widget.hintString.contains("password")) {
                    if (value.trim().isNotEmpty && value.length >= 4) {
                      ref.watch(isPasswordFilledProvider.notifier).state = true;
                    } else {
                      ref.watch(isPasswordFilledProvider.notifier).state =
                          false;
                    }
                  }
                  if (widget.hintString.contains("confirm")) {
                    if (value.trim().isNotEmpty &&
                        passwordText.length == value.length &&
                        passwordText == value &&
                        value.length >= 4) {
                      ref
                          .watch(isConfirmPasswordFilledProvider.notifier)
                          .state = true;
                    } else {
                      ref
                          .watch(isConfirmPasswordFilledProvider.notifier)
                          .state = false;
                    }
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

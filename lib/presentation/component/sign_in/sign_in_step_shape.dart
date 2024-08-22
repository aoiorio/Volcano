import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:volcano/presentation/component/global/white_main_button.dart';
import 'package:volcano/presentation/component/sign_up/sign_up_step_shape.dart';
import 'package:volcano/presentation/provider/front/auth/sign_in_providers.dart';

class SignInStepShape extends ConsumerStatefulWidget {
  const SignInStepShape({
    super.key,
    required this.gradientColorBegin,
    required this.gradientColorEnd,
    required this.stepTitle,
    required this.hintString,
    required this.textEditingControllerType,
  });

  final Color gradientColorBegin;
  final Color gradientColorEnd;
  final String stepTitle;
  final String hintString;
  final TextEditingControllerType textEditingControllerType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignInStepShapeState();
}

class _SignInStepShapeState extends ConsumerState<SignInStepShape> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final textEditingController = ref.watch(
      signInTextEditingControllerProvider(widget.textEditingControllerType),
    );

    final signInStepCounter = ref.watch(signInStepCounterProvider);

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
                  final emailText =
                      ref.read(signInEmailTextControllerProvider).text;
                  final passwordText =
                      ref.read(signInPasswordTextControllerProvider).text;
                  if (emailText.contains('@') && emailText.trim().length >= 3) {
                    ref.read(signInEmailStatusProvider.notifier).state = true;
                  } else {
                    ref.read(signInEmailStatusProvider.notifier).state = false;
                  }
                  if (passwordText.trim().length >= 4) {
                    ref.read(signInPasswordStatusProvider.notifier).state =
                        true;
                  } else {
                    ref.read(signInPasswordStatusProvider.notifier).state =
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
            child: WhiteMainButton(
              titleWidget: Text(
                signInStepCounter == 1 ? '"Finish"' : '"Next"',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
                      color: const Color(0xff343434),
                      fontWeight: FontWeight.bold,
                    ),
              ),
              //signInStepCounter == 1 ? '"Finish"' : '"Next"',
              // widget.hintString.contains('confirm') ? '"Finish"' : '"Next"',
              onPress: () {
                HapticFeedback.mediumImpact();
                signInStepCounter == 1
                    ? context.pop()
                    : ref
                        .watch(signInStepCounterProvider.notifier)
                        .update((state) => state + 1);
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volcano/presentation/provider/sign_up_page_providers.dart';

// TODO add provider and change the class to provider class for changing email, password texts
// class SignUpShapeButton extends ConsumerStatefulWidget {
//   const SignUpShapeButton({
//     super.key,
//     required this.gradientColorBegin,
//     required this.gradientColorEnd,
//     required this.fieldString,
//   });

//   final Color gradientColorBegin;
//   final Color gradientColorEnd;
//   final String fieldString;
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => SignUpShapeButton();
// }

class SignUpShapeButton extends ConsumerStatefulWidget {
  const SignUpShapeButton({
    super.key,
    required this.gradientColorBegin,
    required this.gradientColorEnd,
    required this.fieldString,
  });

  final Color gradientColorBegin;
  final Color gradientColorEnd;
  final String fieldString;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignUpShapeButtonState();
}

class _SignUpShapeButtonState extends ConsumerState<SignUpShapeButton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final textEditingControllerText = widget.fieldString.contains("Email")
        ? ref.watch(emailTextControllerProvider.notifier).state.text
        : widget.fieldString.contains("Password")
            ? ref.watch(passwordTextControllerProvider.notifier).state.text
            : ref
                .watch(confirmPasswordTextControllerProvider.notifier)
                .state
                .text;

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
        ),
        gradient: LinearGradient(
          colors: [widget.gradientColorBegin, widget.gradientColorEnd],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SizedBox(
        width: width,
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              widget.fieldString,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            // TODO Change this text by usign provider, so I'll create three providers which save strings of user input
            Text(
              textEditingControllerText,
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}

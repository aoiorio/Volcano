import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volcano/presentation/component/sign_up/sign_up_step_shape.dart';
import 'package:volcano/presentation/provider/front/auth/sign_up_providers.dart';

// TODOadd provider and change the class to provider class for changing email, password texts
class SignUpShapeButton extends ConsumerStatefulWidget {
  const SignUpShapeButton({
    super.key,
    required this.gradientColorBegin,
    required this.gradientColorEnd,
    required this.fieldString,
    required this.textEditingControllerType,
  });

  final Color gradientColorBegin;
  final Color gradientColorEnd;
  final String fieldString;
  final TextEditingControllerType textEditingControllerType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignUpShapeButtonState();
}

class _SignUpShapeButtonState extends ConsumerState<SignUpShapeButton> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // NOTE find the correct type such as password field, email field or confirm password field
    final textEditingControllerText = widget.textEditingControllerType ==
            TextEditingControllerType.email
        ? ref.watch(signUpEmailTextControllerProvider.notifier).state.text
        : widget.textEditingControllerType == TextEditingControllerType.password
            ? ref
                .watch(signUpPasswordTextControllerProvider.notifier)
                .state
                .text
            : ref
                .watch(signUpConfirmPasswordTextControllerProvider.notifier)
                .state
                .text;

    return DecoratedBox(
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
            const SizedBox(height: 10),
            // TODOChange this text by using provider, so I'll create three providers which save strings of user input
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Text(
                // NOTE hide password values
                widget.fieldString.contains('Email')
                    ? textEditingControllerText
                    : textEditingControllerText.replaceAll(RegExp(r'.'), '*'),
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

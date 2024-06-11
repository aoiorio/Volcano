import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volcano/presentation/provider/front/sign_in/sign_in_page_providers.dart';

// TODOadd provider and change the class to provider class for changing email, password texts
class SignInShapeButton extends ConsumerStatefulWidget {
  const SignInShapeButton({
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
      _SignInShapeButtonState();
}

class _SignInShapeButtonState extends ConsumerState<SignInShapeButton> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textEditingControllerText = widget.fieldString.contains('Email')
        ? ref.watch(signInEmailTextControllerProvider).text
        : ref.watch(signInPasswordTextControllerProvider).text;

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
            Text(
              // NOTE hide password values
              widget.fieldString.contains('Email')
                  ? textEditingControllerText
                  : textEditingControllerText.replaceAll(RegExp(r'.'), '*'),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

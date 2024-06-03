import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volcano/presentation/provider/sign_up_page_providers.dart';

class SignUpTextShape extends ConsumerWidget {
  const SignUpTextShape({
    super.key,
    required this.gradientColorBegin,
    required this.gradientColorEnd,
    required this.stepTitle,
    required this.hintString,
    required this.textEditingController,
    // required this.isFilledProvider,
  });

  final Color gradientColorBegin;
  final Color gradientColorEnd;
  final String stepTitle;
  final String hintString;
  final TextEditingController textEditingController;
  // final StateProvider isFilledProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                  colors: [gradientColorBegin, gradientColorEnd],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            child: Text(
              stepTitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white),
            ),
          ),
          Positioned(
            // bottom: 20,
            child: SizedBox(
              width: 300,
              height: 90,
              child: TextField(
                controller: textEditingController,
                onChanged: (value) {
                  if (!value.contains("@") && hintString.contains("email")) {
                    ref.watch(isEmailFilledProvider.notifier).state = false;
                  } else if (hintString.contains("email")) {
                    ref.watch(isEmailFilledProvider.notifier).state = true;
                  } else if (hintString == '"password"') {
                    ref.watch(isPasswordFilledProvider.notifier).state = true;
                  } else if (hintString == '"confirm pw') {
                    ref.watch(isConfirmPasswordFilledProvider.notifier).state =
                        true;
                  }
                },
                cursorColor: Colors.grey,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(30),
                  filled: true,
                  fillColor: const Color(0xff343434),
                  hintText: hintString,
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
        ],
      ),
    );
  }
}

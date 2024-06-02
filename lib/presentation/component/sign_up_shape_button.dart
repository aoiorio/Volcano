import 'package:flutter/material.dart';

// TODO add provider and change the class to provider class for changing email, password texts
class SignUpShapeButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      // clipBehavior: Clip.hardEdge,
      // padding: EdgeInsets.only(bottom: ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
        ),
        gradient: LinearGradient(
          colors: [gradientColorBegin, gradientColorEnd],
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
              fieldString,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            // TODO Change this text by usign provider, so I'll create three providers which save strings of user input
            Text(
              "something@gmail.com",
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}

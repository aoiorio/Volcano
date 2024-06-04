import 'package:flutter/material.dart';
import 'package:volcano/presentation/component/bounced_button.dart';

class SignUpMainButton extends StatelessWidget {
  const SignUpMainButton({
    super.key,
    required this.title,
    required this.onPress,
  });

  final String title;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 75,
      child: BouncedButton(
        onPress: () {
          onPress();
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 20, color: const Color(0xff343434)),
          ),
        ),
      ),
    );
  }
}

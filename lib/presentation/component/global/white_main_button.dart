import 'package:flutter/material.dart';
import 'package:volcano/presentation/component/global/bounced_button.dart';

class WhiteMainButton extends StatelessWidget {
  const WhiteMainButton({
    super.key,
    required this.titleWidget,
    required this.onPress,
  });

  final Widget titleWidget;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 75,
      child: BouncedButton(
        onPress: onPress,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: titleWidget,
        ),
      ),
    );
  }
}

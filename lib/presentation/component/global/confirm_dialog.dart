import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:volcano/presentation/component/global/bounced_button.dart';

class ConfirmDialog extends ConsumerWidget {
  const ConfirmDialog({
    super.key,
    required this.message,
    required this.onPressedYes,
    required this.onPressedNo,
  });

  final String message;
  final void Function() onPressedYes;
  final void Function() onPressedNo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width / 1.5,
      height: height / 2,
      margin: EdgeInsets.only(
        right: width >= 800 ? width * 0.3 : 20,
        left: width >= 800 ? width * 0.3 : 20,
        top: width >= 800 && width <= 850 ? height * 0.35 : height * 0.3, // 250
        bottom: width >= 800 && width <= 850 ? height * 0.35 : height * 0.3,
      ),
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(100),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '"$message"',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black, fontSize: 20),
          ),
          const Gap(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BouncedButton(
                onPress: onPressedNo,
                child: Container(
                  width: 100,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xff333333),
                  ),
                  child: Text(
                    '"NO"',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 16),
                  ),
                ),
              ),
              const Gap(60),
              BouncedButton(
                onPress: onPressedYes,
                child: Container(
                  width: 100,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xff806E6E),
                  ),
                  child: Text(
                    '"YES"',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// done make global dialog here
void showConfirmDialog(
  BuildContext context,
  String message,
  void Function() onPressedYes,
  void Function() onPressedNo,
) {
  showDialog<void>(
    context: context,
    builder: (_) {
      return ConfirmDialog(
        message: message,
        onPressedYes: onPressedYes,
        onPressedNo: onPressedNo,
      );
    },
  );
}

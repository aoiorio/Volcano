import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:volcano/gen/assets.gen.dart';
import 'package:volcano/presentation/component/global/bounced_button.dart';

class ToSignUpDialog extends HookConsumerWidget {
  const ToSignUpDialog({
    super.key,
    required this.messageToShow,
  });

  final String messageToShow;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      constraints: BoxConstraints(minWidth: width / 1.5, minHeight: height / 2),
      margin: EdgeInsets.only(
        right: width >= 800 ? width * 0.3 : 20,
        left: width >= 800 ? width * 0.3 : 20,
        top: width >= 800 && width <= 850 ? height * 0.3 : 190, // 250
        bottom: width >= 800 && width <= 850 ? height * 0.3 : 190, // 190,
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
            '"$messageToShow"',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black, fontSize: 20),
          ),
          const Gap(10),
          Assets.images.unlockPicture.image(width: 250, height: 150),
          const Gap(10),
          BouncedButton(
            onPress: () {
              HapticFeedback.lightImpact();
              context.push('/sign-up');
            },
            child: Container(
              width: 140,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xff333333),
              ),
              child: Text(
                '"GOT IT"',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showToSignUpDialog(
  BuildContext context, {
  // NOTE optional parameter of this function messageToShow
  String messageToShow = 'You have to SIGN IN to unlock all features!',
}) {
  showDialog<void>(
    context: context,
    builder: (_) {
      return ToSignUpDialog(
        messageToShow: messageToShow,
      );
    },
  );
}

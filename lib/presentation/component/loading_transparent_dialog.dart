import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<void> showLoadingDialog({
  required BuildContext context,
}) async {
  await showGeneralDialog(
    context: context,
    barrierDismissible: false,
    transitionDuration: const Duration(milliseconds: 250),
    barrierColor: Colors.black.withOpacity(0.5), // 画面マスクの透明度
    pageBuilder: (
      BuildContext context,
      Animation<dynamic> animation,
      Animation<dynamic> secondaryAnimation,
    ) {
      return const PopScope(
        canPop: false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitPouringHourGlass(
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    },
  );
}

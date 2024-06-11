import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastWidgetKind {
  error,
  success,
  info,
}

void showToastMessage(
  FToast toast,
  String message,
  ToastWidgetKind kind,
) {
  final child = kind.name == 'error'
      ? toastErrorWidget(message)
      : toastSuccessWidget(message);
  return toast.showToast(
    child: child,
    gravity: ToastGravity.CENTER,
    // NOTE it means that if this toast is active and the user is trying to active it again, the old toast will be disable
    isDismissable: true,
  );
}

Widget toastSuccessWidget(String message) => Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 0, 0, 0),
            Color.fromARGB(255, 79, 78, 78),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Text(
        '"$message"',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );

Widget toastErrorWidget(String message) => Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 123, 105, 105),
            Color.fromARGB(255, 100, 80, 80),
            // Color.fromARGB(255, 97, 90, 90),
            // Color.fromARGB(255, 111, 50, 50),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Text(
        '"$message"',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );

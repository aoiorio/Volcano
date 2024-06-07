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
  final Widget child = kind.name == 'error'
      ? toastErrorWidget(message)
      : toastSuccessWidget(message);
  return toast.showToast(
    child: child,
    gravity: ToastGravity.CENTER,
  );
}

Widget toastSuccessWidget(String message) => Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        // borderRadius: BorderRadius.circular(0),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 0, 0, 0),
            Color.fromARGB(255, 53, 53, 53),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Text(
        '"$message"',
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );

Widget toastErrorWidget(String message) => Container(
      padding: const EdgeInsets.all(10),
      decoration: const  BoxDecoration(
        // borderRadius: BorderRadius.circular(0),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 115, 64, 64),
            Color.fromARGB(255, 111, 50, 50),
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

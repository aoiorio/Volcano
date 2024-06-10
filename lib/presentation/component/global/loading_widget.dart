import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black.withOpacity(0.3),
      child: const Center(
        child: SpinKitPouringHourGlass(
          color: Colors.white,
        ),
      ),
    );
  }
}

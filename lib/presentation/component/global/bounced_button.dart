import 'package:flutter/material.dart';

class BouncedButton extends StatefulWidget {
  const BouncedButton({super.key, required this.child, required this.onPress});
  final Widget child;
  final VoidCallback onPress;

  @override
  State<BouncedButton> createState() => _BouncedButtonState();
}

class _BouncedButtonState extends State<BouncedButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      // lowerBound: 0,
      upperBound: 0.03,
    );
    _controller.addListener(() {
      setState(() {});
    });
  }

  // NOTE _controller must be above the super.dispose() method here!!!
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      setState(() {});
    }
    _scale = 1 - _controller.value;
    return Listener(
      onPointerDown: (event) {
        _controller.forward();
      },
      onPointerUp: (event) {
        _controller.reverse();
        widget.onPress();
      },
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTextField extends ConsumerWidget {
  const CustomTextField({
    super.key,
    required this.textEditingController,
    required this.width,
    required this.height,
    required this.onChanged,
    this.hintString,
    this.addTitle = false,
    this.titleText = '',
  });

  final TextEditingController textEditingController;
  final double width;
  final double height;
  final void Function(String)? onChanged;
  final String? hintString;
  final bool addTitle;
  final String? titleText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addTitle
            ? Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  '"$titleText"',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.black),
                ),
              )
            : const SizedBox(),
        SizedBox(
          width: width,
          height: height,
          child: TextField(
            controller: textEditingController,
            onChanged: onChanged,
            cursorColor: Colors.grey,
            style: const TextStyle(color: Colors.white, fontSize: 18),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 26,
                bottom: 26,
              ),
              filled: true,
              isDense: true,
              fillColor: const Color(0xff343434),
              hintText: hintString,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: Color(0xff343434),
                ),
              ),
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

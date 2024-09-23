import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:volcano/gen/assets.gen.dart';
import 'package:volcano/presentation/component/global/bounced_button.dart';
import 'package:volcano/presentation/component/global/custom_text_field.dart';
import 'package:volcano/presentation/component/global/white_main_button.dart';
import 'package:volcano/presentation/provider/back/todo/controller/post_todo_controller.dart';
import 'package:volcano/presentation/provider/front/todo/reset_values.dart';
import 'package:volcano/presentation/provider/front/todo/step_count.dart';
import 'package:volcano/presentation/provider/global/is_done_tutorial.dart';

class AddTodoDialog extends ConsumerWidget {
  const AddTodoDialog({
    super.key,
    required this.isAddingFromText,
  });

  final bool isAddingFromText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toast = FToast();
    final postTodoControllerNotifier =
        ref.watch(postTodoControllerProvider.notifier);
    final addTodoStepCounter = ref.watch(addTodoStepCountProvider);
    final period = ref.watch(todoPeriodProvider);
    final todoPeriodSuffix = period.hour < 12 ? 'a.m.' : 'p.m.';
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final textWidgets = <Widget>[
      const Column(
        children: [
          Text(
            '"We Recognized Them"',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            '"Click To Update"',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
      Text(
        '"Please Write \n About Your TODO"',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: width <= 375 ? 16 : 20),
      ),
    ];

    final stepWidgets = <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: height * 0.02),
          GestureDetector(
            onTap: () {
              ref.read(resetValuesProvider.notifier).resetValues();
              if (!ref.watch(isDoneTutorialProvider)) {
                ref
                    .read(isDoneTutorialProvider.notifier)
                    .changeIsDoneTutorial();
              }
              context.pop();
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 20, top: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.close,
                  color: Color(0xff747474),
                ),
              ),
            ),
          ),
          SizedBox(height: width <= 375 ? height * 0.01 : height * 0.03), // 20
          isAddingFromText ? textWidgets[1] : textWidgets[0],
          const SizedBox(height: 25),
          CustomTextField(
            textEditingController:
                postTodoControllerNotifier.titleTextController,
            width: width * 0.72, // 280
            height: 80,
            addTitle: true,
            titleText: 'Title',
            hintString: 'type title here...',
            onChanged: (value) {},
          ),
          const SizedBox(height: 30),
          CustomTextField(
            textEditingController:
                postTodoControllerNotifier.typeTextController,
            width: width * 0.72, // 280
            height: 80,
            addTitle: true,
            titleText: 'Type',
            hintString: 'type type here...',
            onChanged: (value) {},
          ),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '"Period"',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () async {
                  BottomPicker.dateTime(
                    pickerTitle: const SizedBox(),
                    dateOrder: DatePickerDateOrder.dmy,
                    initialDateTime: period,
                    onChange: (date) {
                      ref.read(todoPeriodProvider.notifier).state =
                          date as DateTime;
                    },
                    onSubmit: (date) {
                      ref.read(todoPeriodProvider.notifier).state =
                          date as DateTime;
                    },
                    use24hFormat: true,
                    backgroundColor: const Color(0xffF1F1F1),
                    closeIconSize: 30,
                    titlePadding: const EdgeInsets.all(10),
                    pickerTextStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 18),
                    height: height / 3,
                    buttonStyle: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xffBBC6C9),
                          Color(0xffA6A4AD),
                        ],
                      ),
                    ),
                    // NOTE if the user taps the outside of widget, it will disable
                    dismissable: true,
                    buttonContent: const SizedBox(
                      width: 120,
                      height: 40,
                      child: Icon(Icons.check, color: Color(0xff434343)),
                    ),
                  ).show(context);
                },
                child: Container(
                  width: width * 0.72,
                  height: 80,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  decoration: BoxDecoration(
                    color: const Color(0xff343434),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${period.year}-${period.month}-${period.day} ${period.hour}.$todoPeriodSuffix',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      const Spacer(),
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: const Color(0xffD9D9D9),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: width >= 800 && width <= 850
                ? height * 0.05
                : width >= 850
                    ? height * 0.08
                    : 36,
          ),
          WhiteMainButton(
            titleWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('"'),
                Assets.images.arrowBlack.svg(width: 18),
                const Text('"'),
              ],
            ),
            onPress: () {
              ref.read(addTodoStepCountProvider.notifier).increment();
            },
          ),
          Gap(height * 0.03),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: height * 0.02),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 5),
            child: Align(
              alignment: Alignment.topLeft,
              child: BouncedButton(
                child: const Icon(
                  Icons.arrow_back,
                  color: Color(0xff747474),
                ),
                onPress: () {
                  ref.read(addTodoStepCountProvider.notifier).decrement();
                },
              ),
            ),
          ),
          // const SizedBox(height: 20),
          SizedBox(height: width <= 375 ? height * 0.01 : height * 0.03), // 20
          isAddingFromText ? textWidgets[1] : textWidgets[0],
          const SizedBox(height: 30),
          Container(
            alignment: Alignment.center,
            width: width * 0.72,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    '"Description"',
                    style: width <= 375
                        ? const TextStyle(fontSize: 16)
                        : Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black),
                  ),
                ),
                Container(
                  width: width * 0.72, // 280
                  height: 224,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xff343434),
                  ),
                  child: TextField(
                    controller:
                        postTodoControllerNotifier.descriptionTextController,
                    maxLines: null,
                    cursorColor: Colors.grey,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 26,
                        bottom: 26,
                      ),
                      enabledBorder: InputBorder.none,
                      hintText: MediaQuery.of(context).size.width >= 800
                          ? 'type description here...'
                          : 'type description\nhere...',
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
                          .copyWith(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Container(
            alignment: AlignmentDirectional.center,
            width: width * 0.72,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '"Priority"',
                  style: width <= 375
                      ? const TextStyle(fontSize: 16)
                      : Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.black),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: width * 0.72, // 280
                  height: 80,
                  child: CustomDropdown(
                    closedHeaderPadding: const EdgeInsets.all(30),
                    expandedHeaderPadding: const EdgeInsets.all(30),
                    listItemPadding: const EdgeInsets.all(30),
                    items: const [1, 2, 3, 4, 5],
                    initialItem: postTodoControllerNotifier.priority,
                    decoration: CustomDropdownDecoration(
                      expandedFillColor: const Color(0xff343434),
                      closedFillColor: const Color(0xff343434),
                      closedBorderRadius: BorderRadius.circular(30),
                      expandedBorderRadius: BorderRadius.circular(30),
                      listItemStyle: Theme.of(context).textTheme.bodySmall,
                      headerStyle: Theme.of(context).textTheme.bodySmall,
                      closedSuffixIcon: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: const Color(0xffD9D9D9),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      expandedSuffixIcon: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: const Color(0xffD9D9D9),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      listItemDecoration: const ListItemDecoration(
                        highlightColor: Color(0xff504F4F),
                      ),
                    ),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      postTodoControllerNotifier.priority = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: width >= 800 && width <= 850
                ? height * 0.05
                : width >= 850
                    ? height * 0.08
                    : 36,
          ),
          WhiteMainButton(
            titleWidget: Text(
              '"Add TODO"',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            onPress: () {
              // DONE add post todo method here
              isAddingFromText
                  ? postTodoControllerNotifier.postTodoFromText(toast, context)
                  : postTodoControllerNotifier.postTodo(toast, context);
              if (!ref.watch(isDoneTutorialProvider)) {
                ref
                    .read(isDoneTutorialProvider.notifier)
                    .changeIsDoneTutorial();
              }
              context.pop();
            },
          ),
          Gap(height * 0.03),
        ],
      ),
    ];

    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: Container(
        height: 100,
        width: 100,
        margin: EdgeInsets.only(
          right: 30,
          left: 30,
          top: 800 <= width && width <= 850 ? 200 : 20,
          bottom: 800 <= width && width <= 850 ? 200 : 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [
              Color(0xffABBABE),
              Color(0xffA6A4AD),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          // NOTE to show gradient background, it must be transparent
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Center(
              child: stepWidgets[addTodoStepCounter],
            ),
          ),
        ),
      ),
    );
  }
}

void showAddTodoDialog(BuildContext context, {bool isAddingFromText = false}) {
  showDialog<void>(
    context: context,
    // NOTE to not disable the dialog with one tap
    barrierDismissible: false,
    builder: (_) {
      return PopScope(
        child: AddTodoDialog(
          isAddingFromText: isAddingFromText,
        ),
        onPopInvoked: (didPop) {
          // TODO? return confirm page
          debugPrint('Are you sure?');
        },
      );
    },
  );
}

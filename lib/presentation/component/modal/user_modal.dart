import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:volcano/gen/assets.gen.dart';
import 'package:volcano/presentation/component/global/bounced_button.dart';
import 'package:volcano/presentation/component/global/confirm_dialog.dart';
import 'package:volcano/presentation/component/global/custom_toast.dart';
import 'package:volcano/presentation/component/global/shimmer_widget.dart';
import 'package:volcano/presentation/provider/back/auth/shared_preference.dart';
import 'package:volcano/presentation/provider/back/user/controller/delete_user_controller.dart';
import 'package:volcano/presentation/provider/back/user/controller/get_user_info_controller.dart';
import 'package:volcano/presentation/provider/back/user/controller/update_user_controller.dart';

final isEditingProvider = AutoDisposeStateProvider((ref) => false);
final usernameTextEditingControllerProvider = AutoDisposeStateProvider((ref) {
  final username = ref
      .watch(getUserInfoControllerProvider)
      .getRight()
      .fold(() => '', (userInfo) {
    return userInfo.username;
  });
  return TextEditingController(text: username);
});

class UserModal extends HookConsumerWidget {
  const UserModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final userInfo = ref
        .watch(getUserInfoControllerProvider)
        .getRight()
        .fold(() => null, (userInfo) => userInfo);
    final toast = FToast();
    final isEditing = useState(false);
    final usernameTextEditingController =
        ref.watch(usernameTextEditingControllerProvider);

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref
              .read(getUserInfoControllerProvider.notifier)
              .executeGetUserInfo(toast: toast, context: context);
        });
        toast.init(context);
        return;
      },
      [],
    );

    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.width >= 850
                  ? height / 3 + 30
                  : height / 2 + 90,
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 20, bottom: 30),
            child: userInfo == null
                // DONE add shimmer effect
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(10),
                          const Center(
                            child: Row(
                              children: [
                                ShimmerWidget(
                                  width: 130,
                                  height: 130,
                                  radius: 30,
                                ),
                                Gap(30),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ShimmerWidget(width: 190, height: 25),
                                    Gap(10),
                                    ShimmerWidget(width: 190, height: 25),
                                    Gap(10),
                                    ShimmerWidget(width: 190, height: 25),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Gap(30),
                          const Row(
                            children: [
                              ShimmerWidget(
                                width: 260,
                                height: 40,
                              ),
                              Gap(30),
                              Row(
                                children: [
                                  ShimmerWidget(
                                    width: 50,
                                    height: 50,
                                    radius: 15,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          width >= 850
                              ? const Column(
                                  children: [
                                    Gap(10),
                                    ShimmerWidget(width: 200, height: 30),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Gap(10),
                                    const ShimmerWidget(width: 200, height: 30),
                                    const Gap(40),
                                    const ShimmerWidget(
                                      width: 250,
                                      height: 55,
                                      radius: 20,
                                    ),
                                    const Gap(30),
                                    Row(
                                      children: [
                                        const ShimmerWidget(
                                          width: 250,
                                          height: 55,
                                          radius: 20,
                                        ),
                                        Gap(width * 0.1),
                                        const ShimmerWidget(
                                          width: 50,
                                          height: 50,
                                          radius: 15,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ],
                      ),
                      width >= 850
                          ? const Row(
                              children: [
                                Gap(100),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Gap(50),
                                    ShimmerWidget(
                                      width: 250,
                                      height: 55,
                                      radius: 20,
                                    ),
                                    Gap(30),
                                    Row(
                                      children: [
                                        ShimmerWidget(
                                          width: 250,
                                          height: 55,
                                          radius: 20,
                                        ),
                                        Gap(30),
                                        ShimmerWidget(
                                          width: 50,
                                          height: 50,
                                          radius: 15,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(10),
                          Center(
                            child: Row(
                              children: [
                                Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.grey[300],
                                  ),
                                  child: Assets.images.volcanoLogo.image(
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                                const Gap(30),
                                Gap(
                                  MediaQuery.of(context).size.width >= 850
                                      ? 60
                                      : 0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '{',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: Colors.black),
                                    ),
                                    Container(
                                      width: 190,
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: width * 0.001,
                                        ),
                                        child: Text(
                                          '"DONE": ${userInfo.doneTodoNum}\n"NOT YET": ${userInfo.notYetTodoNum}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Gap(30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 260,
                                child: isEditing.value
                                    ? TextField(
                                        // NOTE focus automatically when pressed the button
                                        autofocus: true,
                                        controller:
                                            usernameTextEditingController,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: Colors.black,
                                              fontSize: 30,
                                            ),
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          hintText: 'Type username',
                                          border: InputBorder.none,
                                        ),
                                      )
                                    : Text(
                                        userInfo.username == null
                                            ? '"Who you are"'
                                            : '"${usernameTextEditingController.text.isEmpty ? userInfo.username : usernameTextEditingController.text}"',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: Colors.black,
                                              fontSize: 30,
                                            ),
                                      ),
                              ),
                              Gap(width * 0.1), // 0.08
                              BouncedButton(
                                onPress: isEditing.value
                                    ? () {
                                        ref
                                            .read(
                                              updateUserControllerProvider
                                                  .notifier,
                                            )
                                            .executeUpdateUser(
                                              email: userInfo.email ?? '',
                                              icon: userInfo.icon ?? '',
                                              toast: toast,
                                              username:
                                                  usernameTextEditingController
                                                      .text,
                                            );
                                        isEditing.value = false;
                                      }
                                    : () {
                                        isEditing.value = true;
                                      },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: isEditing.value
                                        ? const Color(0xff828C83)
                                        : Colors.black,
                                  ),
                                  child: isEditing.value
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        )
                                      : Assets.images.penIcon.svg(),
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
                          SizedBox(
                            width: 340,
                            child: Text(
                              userInfo.email ?? '"example@gmail.com"',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: const Color(0xff525252)),
                            ),
                          ),
                          MediaQuery.of(context).size.width >= 850
                              ? const SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Gap(40),
                                    BouncedButton(
                                      onPress: () {
                                        HapticFeedback.lightImpact();
                                        showConfirmDialog(context,
                                            'Do you really\nwant to SIGN OUT?',
                                            () {
                                          ref
                                              .read(
                                                authSharedPreferenceProvider
                                                    .notifier,
                                              )
                                              .deleteAccessToken();
                                          if (context.mounted) {
                                            context.pushReplacement('/sign-up');
                                          }
                                          showToastMessage(
                                            toast,
                                            "💡 You've Signed Out",
                                            ToastWidgetKind.success,
                                          );
                                        }, () {
                                          context.pop();
                                        });
                                      },
                                      child: Container(
                                        width: 250,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color(0xffB7AFAF),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '"Sign Out"',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    color: Colors.black,
                                                  ),
                                            ),
                                            const Gap(10),
                                            const Icon(Icons.logout),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Gap(30),
                                    Row(
                                      children: [
                                        BouncedButton(
                                          onPress: () {
                                            HapticFeedback.lightImpact();
                                            showConfirmDialog(context,
                                                'Do you really\nwant to DELETE?',
                                                () {
                                              ref
                                                  .read(
                                                    deleteUserControllerProvider
                                                        .notifier,
                                                  )
                                                  .executeDeleteUser(toast);
                                              context
                                                  .pushReplacement('/sign-up');
                                            }, () {
                                              context.pop();
                                            });
                                          },
                                          child: Container(
                                            width: 250,
                                            height: 55,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.black,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '"Delete Account"',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                                const Gap(10),
                                                const Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Gap(width * 0.1),
                                        BouncedButton(
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color(0xff68686D),
                                            ),
                                            child: Assets.images.flagIcon.svg(),
                                          ),
                                          onPress: () {
                                            final url = Uri.parse(
                                              'https://forms.gle/dTYbKZqEWT5k8Bpk8',
                                            );
                                            launchUrl(url);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ],
                      ),
                      width >= 850
                          ? Row(
                              children: [
                                const Gap(100),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Gap(50),
                                    BouncedButton(
                                      onPress: () {
                                        HapticFeedback.lightImpact();
                                        showConfirmDialog(context,
                                            'Do you really\nwant to SIGN OUT?',
                                            () {
                                          ref
                                              .read(
                                                authSharedPreferenceProvider
                                                    .notifier,
                                              )
                                              .deleteAccessToken();
                                          if (context.mounted) {
                                            context.pushReplacement('/sign-up');
                                          }
                                          showToastMessage(
                                            toast,
                                            "💡 You've Signed Out",
                                            ToastWidgetKind.success,
                                          );
                                        }, () {
                                          context.pop();
                                        });
                                      },
                                      child: Container(
                                        width: 250,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color(0xffB7AFAF),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '"Sign Out"',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    color: Colors.black,
                                                  ),
                                            ),
                                            const Gap(10),
                                            const Icon(Icons.logout),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Gap(30),
                                    Row(
                                      children: [
                                        BouncedButton(
                                          onPress: () {
                                            HapticFeedback.lightImpact();
                                            showConfirmDialog(context,
                                                'Do you really\nwant to DELETE?',
                                                () {
                                              ref
                                                  .read(
                                                    deleteUserControllerProvider
                                                        .notifier,
                                                  )
                                                  .executeDeleteUser(toast);
                                              context
                                                  .pushReplacement('/sign-up');
                                            }, () {
                                              context.pop();
                                            });
                                          },
                                          child: Container(
                                            width: 250,
                                            height: 55,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.black,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '"Delete Account"',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                                const Gap(10),
                                                const Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Gap(30),
                                        BouncedButton(
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color(0xff68686D),
                                            ),
                                            child: Assets.images.flagIcon.svg(),
                                          ),
                                          onPress: () {
                                            final url = Uri.parse(
                                              'https://forms.gle/dTYbKZqEWT5k8Bpk8',
                                            );
                                            launchUrl(url);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volcano/presentation/page/sign_up/sign_up_page.dart';
import 'package:volcano/presentation/page/volcano/volcano_page.dart';
import 'package:volcano/presentation/provider/back/auth/auth_shared_preference.dart';

class StartPage extends ConsumerWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // NOTE confirm that the user is Signed in or not now
    final authSharedPreference = ref.watch(authSharedPreferenceProvider);
    // final authSharedPreferenceNotifier =
    //     ref.watch(authSharedPreferenceProvider.notifier);
    // authSharedPreferenceNotifier.deleteAccessToken();
    return Scaffold(
      body: authSharedPreference.isEmpty
          ? const SignUpPage()
          : const VolcanoPage(),
    );
  }
}

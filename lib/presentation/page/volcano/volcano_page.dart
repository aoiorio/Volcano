import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volcano/presentation/provider/back/auth/auth_shared_preference.dart';
import 'package:volcano/presentation/provider/back/user/user_providers.dart';

class VolcanoPage extends ConsumerWidget {
  const VolcanoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userUseCase = ref.read(userUseCaseProvider);
    final authSharedPreference = ref.watch(authSharedPreferenceProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: ,
        title: const Text('h i i i ii i'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: ElevatedButton(
                onPressed: () {
                  userUseCase.executeReadUser(authSharedPreference);
                },
                child: const Text(
                  'Hi there push this button to get your info',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

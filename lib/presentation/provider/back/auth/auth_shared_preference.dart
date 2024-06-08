// TODOcreate class with Provider and it will give me some methods such as signUp, signIn and signOut
// TODOuse FutureProvider for loading page
// I think I don't need to create a class though

// final signUpFutureProvider =
//     FutureProvider<Either<AuthError, VolcanoUser>>((ref) async {
//   final result = await ref.watch(authUseCaseProvider).executeSignUp(
//       email: ref.read(emailTextControllerProvider).text,
//       password: ref.read(passwordTextControllerProvider).text,
//       confirmPassword: ref.read(confirmPasswordTextControllerProvider).text);
//   print(result);
//   // await Future.delayed(const Duration(seconds: 2), () {});
//   // これ！！！！！！！

//   print('done');
//   return result;
// });
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_shared_preference.g.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferences>((_) => throw UnimplementedError());

@riverpod
class AuthSharedPreference extends _$AuthSharedPreference {
  @override
  String build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    // Notifierクラスのbuild内でrefを使用可能
    final prefAccessToken = prefs.getString('accessToken') ?? '';
    return prefAccessToken;
  }

  void setAccessToken(String accessToken) {
    final prefs = ref.watch(sharedPreferencesProvider);

    // ignore: cascade_invocations
    prefs.setString('accessToken', accessToken);
  }

  void getAccessToken() {
    final prefs = ref.watch(sharedPreferencesProvider);

    final prefName = prefs.getString('accessToken') ?? '';
    state = prefName;
  }

  void deleteAccessToken() {
    final prefs = ref.watch(sharedPreferencesProvider);
    // ignore: cascade_invocations
    prefs.remove('accessToken');
  }
}

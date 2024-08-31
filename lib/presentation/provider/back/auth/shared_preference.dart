import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../global/shared_preference_provider.dart';

part 'shared_preference.g.dart';


@riverpod
class AuthSharedPreference extends _$AuthSharedPreference {
  @override
  String build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final prefAccessToken = prefs.getString('accessToken') ?? '';
    return prefAccessToken;
  }

  void setAccessToken(String accessToken) {
    final prefs = ref.watch(sharedPreferencesProvider);

    // ignore: cascade_invocations
    prefs.setString('accessToken', accessToken);
    // state = accessToken;
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
    state = '';
  }
}

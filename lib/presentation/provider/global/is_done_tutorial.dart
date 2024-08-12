import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volcano/presentation/provider/back/auth/shared_preference.dart';

part 'is_done_tutorial.g.dart';

@riverpod
class IsDoneTutorial extends _$IsDoneTutorial {
  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final prefIsDoneTutorial = prefs.getBool('isDoneTutorial') ?? false;
    return prefIsDoneTutorial;
  }

  void changeIsDoneTutorial() {
    final prefs = ref.watch(sharedPreferencesProvider);
    // ignore: cascade_invocations
    prefs.setBool('isDoneTutorial', !state);
    state = !state;
  }

  void deleteIsDoneTutorial() {
    final prefs = ref.watch(sharedPreferencesProvider);
    // ignore: cascade_invocations
    prefs.remove('isDoneTutorial');
    state = false;
  }
}

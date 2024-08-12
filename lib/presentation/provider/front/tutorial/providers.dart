import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:volcano/presentation/page/tutorial/tutorial_page.dart';

final tutorialStatusProvider = StateProvider<TutorialStatus>((ref) {
  return TutorialStatus.notYet;
});

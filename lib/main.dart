import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest.dart' as tz;
// ignore: depend_on_referenced_packages
import 'package:timezone/standalone.dart' as tz;
import 'package:volcano/presentation/component/global/loading_widget.dart';
import 'package:volcano/presentation/provider/global/progress_controller.dart';
import 'package:volcano/presentation/routes/routes.dart';
import 'package:volcano/presentation/theme/theme.dart';

import 'presentation/provider/global/shared_preference_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // NOTE set the local timezone (e.g. if you are in Tokyo, it might be 'Asia/Tokyo')
  tz.initializeTimeZones();
  final timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // NOTE allow orientation to up
  ]);
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(
          await SharedPreferences.getInstance(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  // This widget is the root of Volcano.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      title: 'Volcano',
      theme: createTheme(),
      builder: (context, child) {
        final progress = ref.watch(progressControllerProvider);
        return Stack(
          children: [
            child!,
            if (progress) const Center(child: LoadingWidget()),
          ],
        );
      },
    );
  }
}

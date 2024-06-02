import 'package:flutter/material.dart';
import 'package:volcano/presentation/page/sign_up_page.dart';
import 'package:volcano/presentation/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of Volcano.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Volcano',
      theme: createTheme(),
      home: const SignUpScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO Check wether the user signed in or not by using SharedPreferences
    return const Scaffold();
  }
}

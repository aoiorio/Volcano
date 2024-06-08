// DONE Implement routes by using go_router package
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:volcano/presentation/page/sign_in/sign_in_page.dart';
import 'package:volcano/presentation/page/sign_up/sign_up_step_page.dart';
import 'package:volcano/presentation/page/start/start_page.dart';
import 'package:volcano/presentation/page/volcano/volcano_page.dart';

/// The route configuration.
final GoRouter goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'startPage',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const StartPage(),
        );
      },
    ),
    // NOTE SignUpPage router
    GoRoute(
      path: '/sign-up-step',
      name: 'signUpStep',
      pageBuilder: (context, state) =>
          buildTransitionPage(child: const SignUpStepPage()),
    ),
    GoRoute(
      path: '/sign-in',
      name: 'signIn',
      pageBuilder: (context, state) =>
          buildTransitionPage(child: const SignInPage()),
    ),
    GoRoute(
      path: '/volcano',
      name: 'volcano',
      pageBuilder: (context, state) =>
          buildTransitionPage(child: const VolcanoPage()),
    ),
  ],
);

CustomTransitionPage<T> buildTransitionPage<T>({
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SharedAxisTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.horizontal,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 500),
  );
}

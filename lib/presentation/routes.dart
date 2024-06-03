// TODO Implement routes by using go_router package
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:volcano/presentation/page/sign_up/sign_up_step_page.dart';
import 'package:volcano/presentation/page/sign_up/sign_up_page.dart';

/// The route configuration.
final GoRouter goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'signUpScreen',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const SignUpPage(),
        );
      },
    ),
    // NOTE SignUpPage router
    GoRoute(
        path: '/sign-up-email',
        name: 'sign-up-email',
        pageBuilder: (context, state) =>
            buildTransitionPage(child: const SignUpStepPage())),
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

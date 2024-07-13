// DONE Implement routes by using go_router package
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:volcano/presentation/page/auth/sign_in_page.dart';
import 'package:volcano/presentation/page/auth/sign_in_step_page.dart';
import 'package:volcano/presentation/page/auth/sign_up_step_page.dart';
import 'package:volcano/presentation/page/start/start_page.dart';
import 'package:volcano/presentation/page/todo_details/todo_details_page.dart';
import 'package:volcano/presentation/page/volcano/volcano_page.dart';
import 'package:volcano/presentation/routes/routes_model/todo_details_route_model.dart';

// ANCHOR -  if you use buildTransitionPage for three more times, you shouldn't use it. Because it'll cause flicking in it. So please try to use MaterialPage!
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
      name: 'signUpStepPage',
      pageBuilder: (context, state) =>
          buildTransitionPage(state: state, child: const SignUpStepPage()),
    ),
    GoRoute(
      path: '/sign-in',
      name: 'signInPage',
      pageBuilder: (context, state) => const MaterialPage(child: SignInPage()),
    ),
    GoRoute(
      path: '/sign-in-step',
      name: 'signInStepPage',
      pageBuilder: (context, state) =>
          buildTransitionPage(state: state, child: const SignInStepPage()),
    ),
    GoRoute(
      path: '/volcano',
      name: 'volcanoPage',
      pageBuilder: (context, state) =>
          buildTransitionPage(state: state, child: const VolcanoPage()),
    ),
    GoRoute(
      path: '/todo-details',
      name: 'todoDetailsPage',
      pageBuilder: (context, state) {
        final todoDetailsPageModel = state.extra! as TodoDetailsRouteModel;

        return MaterialPage(
          child: TodoDetailsPage(
            todoDetailsRouteModel: todoDetailsPageModel,
          ),
        );
      },
    ),
  ],
);

CustomTransitionPage<T> buildTransitionPage<T>({
  required Widget child,
  required GoRouterState state,
}) {
  return CustomTransitionPage<T>(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SharedAxisTransition(
        key: state.pageKey,
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.horizontal,
        fillColor: Colors.transparent,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 500),
  );
}

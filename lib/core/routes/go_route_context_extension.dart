
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';

/// Extension on [BuildContext] to simplify navigation
extension GoRouterContextExtension on BuildContext {
  void pop() {
    GoRouter.of(this).pop();
  }

  void goToHomePage() {
    GoRouter.of(this).pushReplacementNamed(RouteNames.home);
  }
  void goToLoginPage() {
    GoRouter.of(this).pushReplacementNamed(RouteNames.login);
  }

  void goToCreatePost() {
    GoRouter.of(this).pushNamed(RouteNames.post);
    // GoRouter.of(this).pushReplacementNamed(RouteNames.post);
  }




}

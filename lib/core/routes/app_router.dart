import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shahin_appify_task/data/share_preference/shared_preference_service.dart';
import 'package:shahin_appify_task/presentation/features/auth/login_screen/login_screen_view.dart';
import 'package:shahin_appify_task/presentation/features/error_screens/not_found_page.dart';
import 'package:shahin_appify_task/presentation/features/home/create_post/create_post_screen.dart';
import 'package:shahin_appify_task/presentation/features/home/home_sreen/home_screen_view.dart';
import 'go_router_notifier.dart';
import 'route_names.dart';
import 'route_paths.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator = GlobalKey(debugLabel: 'shell');

final goRouterProvider = Provider<GoRouter>((ref) {
  bool isDuplicate = false;
  final notifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: initialLocation,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigator,
    refreshListenable: notifier,
    errorBuilder: (context, state) => const NotFoundPage(),
    redirect: (context, state) {
      return null;
    },
    routes: [
      GoRoute(
        path: RoutePaths.home,
        name: RouteNames.home,
        builder: (context, state) =>  HomeScreenView(),
      ),
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => LoginScreenView(),
      ),

      GoRoute(
        path: RoutePaths.post,
        name: RouteNames.post,
        builder: (context, state) => CreatePostScreen(),
      ),

    ],
  );
});

String initialLocation =SharePreferenceUtil.isRememberMe()? RoutePaths.home:RoutePaths.login;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shahin_appify_task/data/share_preference/shared_preference_service.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'common/routes/app_router.dart';
import 'common/themes/themes.dart';
import 'common/utils/logger/providers_logger.dart';

final GlobalKey<NavigatorState> globalkey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await SharePreferenceUtil.init();
    timeago.setLocaleMessages('en', timeago.EnMessages());

    runApp(
      ProviderScope(
        observers: [ProvidersLogger()],
        overrides: const [
        ],
        child: const MyApp(),
      ),
    );
  } catch (e) {
    if (kDebugMode) {
      print("Error during app initialization: $e");
    }
  }
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      key: globalkey,
      onGenerateTitle: (_) => 'EasyCourse',
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      theme: AppThemes.primary(),
    );
  }
}

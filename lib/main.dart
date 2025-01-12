import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shahin_appify_task/services/logger/logger_service.dart';
import 'package:shahin_appify_task/services/logger/providers_logger.dart';
import 'package:shahin_appify_task/services/share_preference/shared_preference_service.dart';
import 'config/routes/app_router.dart';
import 'config/themes/themes.dart';
import 'core/providers/logger_providers.dart';

import 'services/device_info/device_info_service.dart';
import 'package:timeago/timeago.dart' as timeago;

final GlobalKey<NavigatorState> globalkey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await SharePreferenceUtil.init();
    timeago.setLocaleMessages('en', timeago.EnMessages());
    final deviceInfoService = DeviceInfoService();
    await deviceInfoService.initProperInfo();
    runApp(
      ProviderScope(
        observers: [ProvidersLogger()],
        overrides: [
          deviceInfoServiceProvider.overrideWithValue(deviceInfoService),
        ],
        child: MyApp(),
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

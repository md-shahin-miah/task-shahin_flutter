// import 'dart:async';
// import 'dart:developer';
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:darun/controllers/auth_controller/auth_controller.dart';
// import 'package:darun/controllers/visited_history_controller/visited_history_controller.dart';
// import 'package:darun/models/network_request/visited_history_request.dart';
// import 'package:darun/providers/all_providers.dart';
// import 'package:darun/router/go_route_context_extension.dart';
// import 'package:darun/services/shared_preference_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../controllers/favourite_controller/favourite_controller.dart';
// import '../../../network/data_state.dart';
// import '../../../utils/network_connectivity/connectivity_util.dart';
//
// class SplashScreen extends ConsumerStatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   ConsumerState<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends ConsumerState<SplashScreen> {
//   List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
//
//   Future<void> initConnectivity() async {
//     late List<ConnectivityResult> result;
//     try {
//       result = await _connectivity.checkConnectivity();
//     } on PlatformException catch (e) {
//       return;
//     }
//     if (!mounted) {
//       return Future.value(null);
//     }
//
//     return _updateConnectionStatus(result);
//   }
//
//   Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
//     // setState(() {
//     //   _connectionStatus = result;
//     // });
//     // ignore: avoid_print
//     print('Connectivity changed: $_connectionStatus');
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     initConnectivity();
//
//     _connectivitySubscription =
//         _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//     initialize();
//   }
//
//   void initialize() async {
//
//     log(" dataadd->>>>> checkkk");
//     // ref.read(adsProvider).getAdvertisement().then((value) {
//     //   log(" dataadd->>>>> $value");
//     //   timerDelay();
//     // });
//     //
//
//     if (SharePreferenceUtil.getVisitedHistory() != null) {
//       ref
//           .read(visitedHistoryStateNotifierProvider.notifier)
//           .postVisitedHistory(SharePreferenceUtil.getVisitedHistory())
//           .whenComplete(() {
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//
//
//     ref.listen(streamProvider, (previous, next) {
//       final connectivityStream = ref.read(streamProvider);
//
//       log("----previ-->${ref.read(streamProvider).value}");
//
//       log("----√sc ->${connectivityStream.value!=null}");
//       if (connectivityStream.value!=null&& !connectivityStream.value!) {
//         timerDelay();
//         log("con ---11111");
//
//       } else {
//         log("con ---2222");
//         ref.read(adsProvider).getAdvertisement().then((value) {
//           timerDelay();
//         });
//       }
//
//     });
//
//
//
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Spacer(),
//           Center(
//               child: Image.asset(
//                 "assets/image/splash_logo.png",
//                 height: 300,
//                 width: 300,
//               )),
//           const Spacer(),
//         ],
//       ),
//     );
//   }
//
//   void timerDelay() {
//     String token = SharePreferenceUtil.getUserToken();
//     final isBoardingDone = SharePreferenceUtil.isOnBoardingScreenDone();
//     Timer(const Duration(milliseconds: 1000), () {
//       if (!isBoardingDone) {
//         context.goToOnBoardingScreen();
//       } else if (token.isNotEmpty) {
//         context.goToHomePage();
//         ref.read(favouriteListFutureProvider(SharePreferenceUtil.getUserId()));
//       } else {
//         context.goToLogInScreen();
//       }
//     });
//   }
// }

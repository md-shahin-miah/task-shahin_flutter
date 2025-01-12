import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../views/screens/auth/login_screen/login_screen_view.dart';
import '../../views/screens/error_screens/not_found_page.dart';

import '../../views/screens/home/home_sreen/home_screen_view.dart';
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
      // GoRoute(
      //   path: RoutePaths.splash,
      //   name: RouteNames.splash,
      //   builder: (context, state) => const SplashScreen(),
      // ),
      // GoRoute(
      //   path: RoutePaths.onBoarding,
      //   name: RouteNames.onBoarding,
      //   builder: (context, state) => const OnBoardingScreen(),
      // ),
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => LoginScreenView(),
      ),
      // GoRoute(
      //   path: RoutePaths.signUp,
      //   name: RouteNames.signUp,
      //   builder: (context, state) =>  SignUpScreen(),
      // ),
      // GoRoute(
      //     path: RoutePaths.changePassword,
      //     name: RouteNames.changePassword,
      //     builder: (context, state) => ChangePasswordScreen()),
      // GoRoute(
      //   path: RoutePaths.otpVerify,
      //   name: RouteNames.otpVerify,
      //   builder: (context, state) {
      //     return OTPVerifyScreen(  intentSection: state.pathParameters['signUp'] ?? "");
      //   },
      // ),
      //
      // GoRoute(
      //   path: RoutePaths.passwordUpdate,
      //   name: RouteNames.passwordUpdate,
      //   builder: (context, state) => PasswordUpdateScreen(),
      // ),
      //
      // GoRoute(
      //   path: RoutePaths.notification,
      //   name: RouteNames.notification,
      //   builder: (context, state) =>  NotificationScreen(),
      // ),
      // GoRoute(
      //   path: RoutePaths.deals,
      //   name: RouteNames.deals,
      //   builder: (context, state) =>  DealsScreen( categoryId: state.pathParameters['categoryId']!),
      // ),
      // GoRoute(
      //   path: RoutePaths.dealsDetails,
      //   name: RouteNames.dealsDetails,
      //   builder: (context, state) {
      //     Deal deal = state.extra as Deal;
      //     return DealsDetailsScreen(deal: deal, dealId: state.pathParameters['dealId']!);
      //   },
      // ),
      // GoRoute(
      //   path: RoutePaths.feedDetails,
      //   name: RouteNames.feedDetails,
      //   builder: (context, state) {
      //     Feed feed = state.extra as Feed;
      //     return FeedDetailsScreen(feed: feed, feedId: state.pathParameters['feedId']!);
      //   },
      // ),
      // GoRoute(
      //   path: RoutePaths.rewardHistoryDetails,
      //   name: RouteNames.rewardHistoryDetails,
      //   builder: (context, state) {
      //     Reward reward = state.extra as Reward;
      //     return RewardHistoryDetailsScreen(reward: reward);
      //   },
      // ),
      // GoRoute(
      //   path: RoutePaths.reviews,
      //   name: RouteNames.reviews,
      //   builder: (context, state) =>  ReviewsScreen(vendorId: state.pathParameters['vendorId']),
      // ),
      // GoRoute(
      //     path: RoutePaths.reviewDetails,
      //     name: RouteNames.reviewDetails,
      //     builder: (context, state) {
      //       Review review = state.extra as Review;
      //       return ReviewDetailsScreen(reviewId: state.pathParameters['reviewId'], review: review);
      //     }),
      // GoRoute(
      //   path: RoutePaths.vendorProfile,
      //   name: RouteNames.vendorProfile,
      //   builder: (context, state) {
      //     Vendor vendor = state.extra as Vendor;
      //     return VendorProfileScreen(vendor: vendor, fromId: state.pathParameters['from_id']??"");
      //   },
      // ),
      // GoRoute(
      //   path: RoutePaths.vouchers,
      //   name: RouteNames.vouchers,
      //   builder: (context, state) {
      //     Vendor vendor = state.extra as Vendor;
      //     return VoucherScreen(vendor: vendor);
      //   },
      // ),
      // GoRoute(
      //   path: RoutePaths.voucherCollect,
      //   name: RouteNames.voucherCollect,
      //   builder: (context, state) {
      //     Voucher voucher=state.extra as Voucher;
      //     return  VoucherCollectScreen(voucher: voucher);
      //   },
      // ),
      // GoRoute(
      //   path: RoutePaths.thankYouScreen,
      //   name: RouteNames.thankYouScreen,
      //
      //   builder: (context, state) {
      //     Voucher voucher=state.extra as Voucher;
      //     return ThankYouScreen(voucher: voucher);
      //   },
      // ),
      // GoRoute(
      //   path: RoutePaths.category,
      //   name: RouteNames.category,
      //   builder: (context, state) =>  CategoryScreen( fromId: state.pathParameters['from_Id']),
      // ),
      // GoRoute(
      //   path: RoutePaths.vendors,
      //   name: RouteNames.vendors,
      //   builder: (context, state) =>  VendorsScreen(type: state.pathParameters['type']),
      // ),
      // GoRoute(
      //   path: RoutePaths.home,
      //   name: RouteNames.home,
      //   builder: (context, state) =>  HomeScreen(ScrollController()),
      // ),
      // GoRoute(
      //   path: RoutePaths.topOffers,
      //   name: RouteNames.topOffers,
      //   builder: (context, state) =>  TopOffersScreen(type: state.pathParameters['type']),
      // ),
      // GoRoute(
      //   path: RoutePaths.UserProfileEdit,
      //   name: RouteNames.UserProfileEdit,
      //   builder: (context, state) {
      //     LoginUser userInfo=state.extra as LoginUser;
      //     return ProfileEditScreen(selfDetailsBody: userInfo);
      //   },
      // ),
    ],
  );
});

String initialLocation = RoutePaths.home;

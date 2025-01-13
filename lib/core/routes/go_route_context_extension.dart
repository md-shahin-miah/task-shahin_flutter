
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';

/// Extension on [BuildContext] to simplify navigation
extension GoRouterContextExtension on BuildContext {
  void pop() {
    GoRouter.of(this).pop();
  }

  // void goHome({
  //   Map<String, String> queryParams = const <String, String>{},
  //   Object? extra,
  // }) {
  //   GoRouter.of(this).goNamed(
  //     RouteNames.home,
  //     queryParameters: queryParams,
  //     extra: extra,
  //   );
  // }
  //
  // void goToReplaceWithHome({
  //   Map<String, String> queryParams = const <String, String>{},
  //   Object? extra,
  // }) {
  //   GoRouter.of(this).replaceNamed(
  //     RouteNames.home,
  //     queryParameters: queryParams,
  //     extra: extra,
  //   );
  // }

  // void goToDetailPage({
  //   Object? args,
  //   String? id,
  // }) =>
  //     GoRouter.of(this).pushNamed(
  //       RouteNames.detail,
  //       extra: args,
  //       pathParameters: {'id': id ?? '0'},
  //     );
  //
  // void goToLogInScreen() {
  //   GoRouter.of(this).pushReplacementNamed(RouteNames.signIn);
  // }
  //
  // void goToRewardHistoryScreen() {
  //   GoRouter.of(this).pushNamed(RouteNames.rewardHistory);
  //
  // }
  //
  // void goChangePassword() {
  //   GoRouter.of(this).pushNamed(RouteNames.changePassword);
  // }
  // void goToUpdatePassword(){
  //   GoRouter.of(this).pushNamed(RouteNames.passwordUpdate);
  // }
  //
  // void goOTPVerify(String intentSection) {
  //   GoRouter.of(this).pushNamed(RouteNames.otpVerify);
  // }

  void goToHomePage() {
    GoRouter.of(this).pushReplacementNamed(RouteNames.home);
  }
  void goToLoginPage() {
    GoRouter.of(this).pushReplacementNamed(RouteNames.login);
  }




  // void goToNotificationScreen() {
  //   GoRouter.of(this).pushNamed(RouteNames.notification);
  // }
  //
  // void goToSignUpScreen() {
  //   GoRouter.of(this).pushNamed(RouteNames.signUp);
  // }
  //
  // void goToOnBoardingScreen() {
  //   GoRouter.of(this).pushReplacementNamed(RouteNames.onBoarding);
  // }

  // void goToDealsDetailsScreen(Deal? deal, String dealId) {
  //   GoRouter.of(this)
  //       .pushNamed(RouteNames.dealsDetails, extra: deal, pathParameters: {'dealId': dealId});
  // }
  //
  // void goToFeedDetailsScreen(Feed? feed_screen, String feedId) {
  //   GoRouter.of(this)
  //       .pushNamed(RouteNames.feedDetails, extra: feed_screen, pathParameters: {'feedId': feedId});
  // }
  //
  // void goToDealsScreen(String vendorId) {
  //   GoRouter.of(this).pushNamed(RouteNames.deals,pathParameters: {'categoryId': vendorId});
  // }
  //
  // void goToRewardHistoryDetailsScreen(Reward reward) {
  //   GoRouter.of(this).pushNamed(RouteNames.rewardHistoryDetails,extra: reward);
  // }
  //
  // void goToReviewsScreen(String vendorId) {
  //   GoRouter.of(this).pushNamed(RouteNames.reviews,pathParameters: {'vendorId': vendorId});
  // }
  //
  // void goToVendorProfile(Vendor? vendor, String from) {
  //   GoRouter.of(this)
  //       .pushNamed(RouteNames.vendorProfile, extra: vendor, pathParameters: {'from_id': from});
  // }
  //
  // void goToVendorsScreen(String type) {
  //   GoRouter.of(this).pushNamed(RouteNames.vendors,pathParameters: {'type': type});
  // }
  // void goToTopOffersScreen(String type) {
  //   GoRouter.of(this).pushNamed(RouteNames.topOffers,pathParameters: {'type': type});
  // }
  //
  // void goToReviewDetailsScreen(Review? review, String reviewId) {
  //   GoRouter.of(this)
  //       .pushNamed(RouteNames.reviewDetails, extra: review, pathParameters: {'reviewId': reviewId});
  // }
  //
  // void goToCategoryScreen(String from_Id) {
  //   GoRouter.of(this).pushNamed(RouteNames.category, pathParameters: {'from_Id': from_Id});
  // }
  //
  // void goToVoucherDetails(Vendor vendor) {
  //   GoRouter.of(this).pushNamed(RouteNames.vouchers,extra: vendor);
  // }
  //
  // void goToVoucherCollect(Voucher voucher) {
  //   GoRouter.of(this).pushNamed(RouteNames.voucherCollect,extra: voucher );
  // }
  //
  // void goToThankYouScreen(Voucher voucher) {
  //   GoRouter.of(this).pushReplacementNamed(RouteNames.thankYouScreen,extra: voucher);
  // }
  // void gotoUserProfileEdit(LoginUser selfDetailsBody){
  //   GoRouter.of(this).pushNamed(RouteNames.UserProfileEdit,extra: selfDetailsBody);
  // }

}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shahin_appify_task/common/constants/app_constant.dart';
import 'package:shahin_appify_task/common/constants/image_assets.dart';
import 'package:shahin_appify_task/common/themes/styles/app_colors.dart';
import 'package:shahin_appify_task/common/utils/snackbar/snackbar_service.dart';
import 'package:shahin_appify_task/data/providers/navigation_provider.dart';
import 'package:shahin_appify_task/presentation/features/home/home_sreen/widget/logout_dialog.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/feeds_screen_view.dart';


final selectedTabIndex = StateProvider((ref) => 0);

class HomeScreenView extends ConsumerWidget {
  HomeScreenView({super.key});
  DateTime BackPressTime = DateTime.now();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(

      onPopInvoked:(pop){
        exiteApp();
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: AppColors.primaryColor,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Image.asset(
              AppImageAssets.toggle,
              width: 36,
              height: 36,
            ),
          ),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppConstant.pythonTitle,
                style: TextStyle(fontSize: 18, color: AppColors.textColorGray2, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2),
              Text(
                AppConstant.subTitleGeneral,
                style: TextStyle(fontSize: 14, color: AppColors.lightGray),
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: ref.watch(uiProviders).pageController,
              onPageChanged: (value) {
                print("-----------> $value");
              },
              children: const [
                FeedScreenView(),
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.groups,
                color: AppColors.primaryColor,
              ),
              label: AppConstant.community,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.output,
                color: AppColors.primaryColor,
              ),
              label: AppConstant.logOut,
            ),
          ],
          currentIndex: ref.read(selectedTabIndex),
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.primaryColor,
          onTap: (value) {
            ref.read(selectedTabIndex.notifier).state = value;
            ref.read(uiProviders.notifier).setSelectedMenuOpt(value);
      
            if (value == 1) {
              showLogoutConfirmDialog(context);
            }
      
            if (kDebugMode) {
              print("-------bottom------->$value");
            }
          },
        ),
      ),
    );
  }

  Future<bool> exiteApp() {
    print("exite app");
    DateTime now = DateTime.now();
    if(now.difference(BackPressTime)< const Duration(seconds: 2)){
      return Future(() => true);
    }
    else{
      BackPressTime = DateTime.now();
      ToastService.showToast(title: "Press again to exit", backgroundColor: AppColors.colorError);
      return Future(()=> false);
    }
  }}


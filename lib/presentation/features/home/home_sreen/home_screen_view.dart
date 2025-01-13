import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shahin_appify_task/core/constants/app_constant.dart';
import 'package:shahin_appify_task/core/constants/image_assets.dart';
import 'package:shahin_appify_task/core/themes/styles/app_colors.dart';
import 'package:shahin_appify_task/data/providers/navigation_provider.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/feeds_screen_view.dart';



final selectedTabIndex = StateProvider((ref) => 0);

class HomeScreenView extends ConsumerWidget {
  HomeScreenView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: AppColors.primary,
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
              style: TextStyle(fontSize: 18, color: AppColors.txtColor2, fontWeight: FontWeight.bold),
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
            children: [
              FeedScreenView(ScrollController()),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.groups,
              color: AppColors.primary,
            ),
            label: AppConstant.community,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.output,
              color: AppColors.primary,
            ),
            label: AppConstant.logOut,
          ),
        ],
        currentIndex: ref.read(selectedTabIndex),
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primaryColor,
        onTap: (value) {

          ref.read(selectedTabIndex.notifier).state=value;
          ref.read(uiProviders.notifier).setSelectedMenuOpt(value);
          if (kDebugMode) {
            print("-------bottom------->$value");
          }
        },
      ),
    );
  }
}

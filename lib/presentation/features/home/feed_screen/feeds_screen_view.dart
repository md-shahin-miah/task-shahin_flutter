import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shahin_appify_task/common/routes/go_route_context_extension.dart';
import 'package:shahin_appify_task/common/themes/styles/app_colors.dart';
import 'package:shahin_appify_task/data/network/models/network_request/feed_request.dart';
import 'package:shahin_appify_task/data/network/models/network_response/feed_response.dart';
import 'package:shahin_appify_task/data/state/data_state.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/feeds_screen_view_model.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/widget/feed_item.dart';
import 'package:shahin_appify_task/presentation/widgets/button/custom_button.dart';
import 'package:shahin_appify_task/presentation/widgets/shimmer/feed_shimmer.dart';
import '../../../../common/constants/image_assets.dart';
import '../../../../common/utils/snackbar/snackbar_service.dart';
import 'widget/comment_bottom_sheet.dart';

class FeedScreenView extends ConsumerWidget {
  const FeedScreenView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    observers(ref, context);

    return RefreshIndicator(
      color: AppColors.primaryColor,
      onRefresh: () {
        return Future.delayed(
          const Duration(seconds: 1),
          () {
            print("------dddd---RefreshIndicator--->");

            invalidateData(ref);
          },
        );
      },
      child: Scaffold(
        body: ref
            .watch(feedFutureProvider(
                FeedRequest(space_id: "5883", community_id: "2914", more: " ")))
            .when(data: (data) {
          FeedResponseList? dataResponse = data;

          if (dataResponse != null) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        context.goToCreatePost();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 1,
                              spreadRadius: 1,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(8),
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage(AppImageAssets.userImage)),
                              ),
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Write something here...',
                                  style: TextStyle(color: AppColors.darkerGray),
                                ),
                              ),
                            ),
                            CustomPrimaryButton(
                              btnText: 'Post',
                              width: null,
                              textSize: 14,
                              toggleObscure: () {},
                              bgColor: AppColors.primaryColor,
                            ),
                            const SizedBox(width: 5),
                          ],
                        ),
                      ),
                    ),
                    // ListView Section
                    ListView.builder(
                      itemCount: dataResponse.feedList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        print("------------------item ->");
                        return FeedItem(
                            feedResponse: dataResponse.feedList[index]);
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
                child: Text("Something went wrong, No Data Found"));
          }
        }, error: (error, e) {
          return SizedBox(
            height: MediaQuery.of(context).size.height-100,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      invalidateData(ref);
                    },
                    child: Text("Retry"),
                  ),
                  const Text("No data found"),
                ],
              ),
            ),
          );

          // }
        }, loading: () {
          return const FeedShimmer();
        }),
      ),
    );
  }

  void observers(WidgetRef ref, BuildContext context) {
    ref.listen<DataState>(createOrDeleteReactionStateNotifierProvider,
        (_, state) {
      state.maybeWhen(
        success: (user) {
          ref.invalidate(reactionFutureProvider);
        },
        error: (err, _) {
          debugPrint(err);
          ToastService.showToast(
              title: err, backgroundColor: AppColors.colorError);
        },
        orElse: () {},
      );
    });
  }

  void invalidateData(WidgetRef ref) {
    ref.invalidate(feedFutureProvider);
    ref.invalidate(replyFutureProvider);
    ref.invalidate(commentFutureProvider);
    ref.invalidate(reactionFutureProvider);
    controllerComment.text = "";
  }
}

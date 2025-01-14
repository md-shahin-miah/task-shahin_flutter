import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shahin_appify_task/core/constants/color_constant_linear.dart';
import 'package:shahin_appify_task/core/constants/image_assets.dart';
import 'package:shahin_appify_task/core/routes/go_route_context_extension.dart';
import 'package:shahin_appify_task/core/themes/styles/app_colors.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_comment_request.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_delete_reaction_request.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_post_request.dart';
import 'package:shahin_appify_task/data/network/models/network_request/feed_request.dart';
import 'package:shahin_appify_task/data/network/models/network_response/feed_response.dart';
import 'package:shahin_appify_task/data/state/data_state.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/feeds_screen_view_model.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/widget/list_item.dart';
import 'package:shahin_appify_task/presentation/widgets/common/app_buttons.dart';
import 'package:shahin_appify_task/presentation/widgets/common/loading_widget.dart';
import '../../../widgets/common/custom_text_field.dart';
import '../../../widgets/common/reactions.dart';

class FeedScreenView extends ConsumerWidget {
  final _controller;

  FeedScreenView(this._controller, {super.key});

  int rtnindex = -1;

  final _conWriteHere = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    print(
        '------------------------>${ColorConstantLinear.findIndex("{\"backgroundImage\":\"linear-gradient(45deg, rgb(255, 115, 0) 0%, rgb(255, 0, 234) 100%)\"}")}');


    observers(ref,context);


    return Scaffold(
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
                  GestureDetector(
                    onTap: () {
                      context.goToCreatePost();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(15),
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
                                  image: AssetImage(AppImageAssets.userImage)),
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
                          CustomButton(
                            btnText: 'Post',
                            width: null,
                            textSize: 14,
                            toggleObscure: () {


                            },
                            bgColor: AppColors.primary,
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
                      return ListItem(dataResponse.feedList[index]);
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text("No Data Found"));
        }
      }, error: (error, e) {

        return const Text("No data found");
        // }
      }, loading: () {
        return  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 1.5, color: AppColors.primary,),
                  )),
            ),
            Text('Loading your feed'),
          ],
        );
      }),
    );
  }

  void observers(WidgetRef ref, BuildContext context) {
    ref.listen<DataState>(createOrDeleteReactionStateNotifierProvider, (_, state) {
      state.maybeWhen(
        success: (user) {

          print("-------createFeedStateNotifierProvider--------->");
          ref.invalidate(feedFutureProvider);

        },
        error: (err, _) {
          debugPrint(err);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(err),
              backgroundColor: AppColors.colorError,
            ),
          );
        },
        orElse: () {},
      );
    });

  }
}

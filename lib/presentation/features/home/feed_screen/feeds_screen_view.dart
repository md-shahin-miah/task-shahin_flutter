import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shahin_appify_task/core/constants/color_constant_linear.dart';
import 'package:shahin_appify_task/core/constants/image_assets.dart';
import 'package:shahin_appify_task/core/themes/styles/app_colors.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_post_request.dart';
import 'package:shahin_appify_task/data/network/models/network_request/feed_request.dart';
import 'package:shahin_appify_task/data/network/models/network_response/feed_response.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/feeds_screen_view_model.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/widget/list_item.dart';
import 'package:shahin_appify_task/presentation/widgets/common/app_buttons.dart';
import '../../../widgets/common/custom_text_field.dart';
import '../../../widgets/common/reactions.dart';

class FeedScreenView extends ConsumerWidget {
  final _controller;

  FeedScreenView(this._controller, {super.key});

  int rtnindex = -1;

  final _conWriteHere = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    print('------------------------>${ColorConstantLinear.findIndex("{\"backgroundImage\":\"linear-gradient(45deg, rgb(255, 115, 0) 0%, rgb(255, 0, 234) 100%)\"}")}');

    return Scaffold(
      body: ref.watch(feedFutureProvider(FeedRequest(space_id: "5883", community_id: "2914", more: " "))).when(data: (data) {
       
        FeedResponseList? dataResponse=data ;

        if(dataResponse!=null){

        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        spreadRadius: 2,
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
                          image: DecorationImage(image: AssetImage(AppImageAssets.userImage)),
                        ),
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: _conWriteHere,
                          isBorder: false,
                          hintText: 'Write something here...',
                          isPassword: false,
                        ),
                      ),
                      CustomButton(
                        btnText: 'Post',
                        width: null,
                        textSize: 14,

                        toggleObscure: () {
                          ref.read(createFeedStateNotifierProvider.notifier).createPost(CreatePostRequest(community_id: "2914",space_id: "5883",activity_type: "group",bg_color: "",feed_txt: "Hello from beg start",is_background: 0,uploadType: "text"));

                        },
                        bgColor: AppColors.primaryDark,
                      ),
                      const SizedBox(width: 5),

                    ],
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
        );}
        else{
         return const Center(child: Text("No Data Found"));
        }
      }, error: (error, e) {
        // if (SharePreferenceUtil.getLandingResponse() !=
        //     null) {
        //   return  Column(
        //     children: [
        //       Container(
        //         margin: const EdgeInsets.all(15),
        //         padding: const EdgeInsets.all(5.0),
        //         decoration: BoxDecoration(
        //           color: AppColors.white,
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.grey.withOpacity(0.2),
        //               blurRadius: 5,
        //               spreadRadius: 2,
        //             ),
        //           ],
        //           borderRadius: BorderRadius.circular(5),
        //         ),
        //         child: Row(
        //           children: [
        //             Container(
        //               width: 65,
        //               height: 65,
        //               decoration: const BoxDecoration(
        //                 image: DecorationImage(image: AssetImage('assets/image.png')),
        //               ),
        //             ),
        //             const SizedBox(width: 10),
        //             Expanded(
        //               child: CustomTextField(
        //                 controller: _conWriteHere,
        //                 isBorder: false,
        //                 hintText: 'Write something here...',
        //                 isPassword: false,
        //               ),
        //             ),
        //             const SizedBox(width: 10),
        //             // CustomButtom(
        //             //   btnText: 'Post',
        //             //   width: null,
        //             //   textSize: 14,
        //             //   toggleObscure: () {},
        //             //   bgColor: AppColors.primaryDark,
        //             // )
        //           ],
        //         ),
        //       ),
        //       // ListView Section
        //       Expanded(
        //         child: ListView.builder(
        //           itemCount: 5,
        //           physics: const NeverScrollableScrollPhysics(),
        //           itemBuilder: (context, index) {
        //             return Padding(
        //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        //               child: Container(
        //                 padding: const EdgeInsets.all(16),
        //                 decoration: BoxDecoration(
        //                   color: Colors.white,
        //                   boxShadow: [
        //                     BoxShadow(
        //                       color: Colors.grey.withOpacity(0.2),
        //                       blurRadius: 5,
        //                       spreadRadius: 2,
        //                     ),
        //                   ],
        //                   borderRadius: BorderRadius.circular(12),
        //                 ),
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     const Row(
        //                       children: [
        //                         CircleAvatar(
        //                           radius: 20,
        //                           backgroundImage: AssetImage('assets/user_avatar.png'),
        //                         ),
        //                         SizedBox(width: 10),
        //                         Column(
        //                           crossAxisAlignment: CrossAxisAlignment.start,
        //                           children: [
        //                             Text(
        //                               "Alexander John",
        //                               style: TextStyle(
        //                                 fontSize: 16,
        //                                 fontWeight: FontWeight.bold,
        //                               ),
        //                             ),
        //                             SizedBox(height: 5),
        //                             Text(
        //                               "2 days ago",
        //                               style: TextStyle(fontSize: 12, color: Colors.grey),
        //                             ),
        //                           ],
        //                         ),
        //                         Spacer(),
        //                         Icon(Icons.more_vert),
        //                       ],
        //                     ),
        //                     const SizedBox(height: 10),
        //                     const Text(
        //                       "Hello everyone - This is a post from the app.",
        //                       style: TextStyle(fontSize: 14),
        //                     ),
        //                     SizedBox(height: 10),
        //                     if (index % 2 == 0) // Example image for alternating items
        //                       Container(
        //                         width: double.infinity,
        //                         height: 180,
        //                         decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.circular(8),
        //                           image: const DecorationImage(
        //                             image: AssetImage('assets/post_image.png'),
        //                             fit: BoxFit.cover,
        //                           ),
        //                         ),
        //                       ),
        //                     const SizedBox(height: 10),
        //                     InkWell(
        //                       onTap: () {},
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           Row(
        //                             children: [
        //                               // makeLike(),
        //                               // Transform.translate(offset: const Offset(-5, 0), child: makeLove()),
        //                               const SizedBox(
        //                                 width: 5,
        //                               ),
        //                               Text(
        //                                 "100",
        //                                 style: TextStyle(fontSize: 15, color: Colors.grey[800]),
        //                               )
        //                             ],
        //                           ),
        //                           Text(
        //                             "No Comments",
        //                             style: TextStyle(fontSize: 13, color: Colors.grey[800]),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                     const SizedBox(
        //                       height: 20,
        //                     ),
        //                     Row(
        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                       children: [
        //                         Container(
        //                           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        //                           child: ReactionButton<String>(
        //                             itemSize: const Size.square(40),
        //                             onReactionChanged: (Reaction<String>? reaction) {
        //                               //do api call here
        //                             },
        //                             reactions: reactions,
        //                             placeholder: rtnindex != -1 ? reactions[rtnindex] : defaultInitialReaction,
        //                             selectedReaction: reactions.first,
        //                           ),
        //                         ),
        //                         buildReactionsIcon(
        //                           'assets/comment.png',
        //                           const Text(
        //                             'Comment',
        //                             style: TextStyle(
        //                               color: Color(0XFF000000),
        //                             ),
        //                           ),
        //                         )
        //                       ],
        //                     )
        //                   ],
        //                 ),
        //               ),
        //             );
        //           },
        //         ),
        //       ),
        //     ],
        //   );
        // } else {
        return const Text("No data found");
        // }
      }, loading: () {
        return Container(
          child: Container(
            child: Text('Loading'),
          ),
        );
      }),
    );
  }
}





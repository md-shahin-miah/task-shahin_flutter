import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:shahin_appify_task/core/constants/color_constant_linear.dart';
import 'package:shahin_appify_task/core/constants/image_assets.dart';

import '../../../../../core/themes/styles/app_colors.dart';
import '../../../../../data/network/models/network_response/feed_response.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../widgets/common/reactions.dart';

class ListItem extends StatelessWidget {
  FeedResponse feedResponse;

  ListItem(this.feedResponse, {super.key});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(feedResponse.createdAt.toString());
    final timeAgo = timeago.format(dateTime);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // color: Colors.white,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.2),
          //     blurRadius: 5,
          //     spreadRadius: 2,
          //   ),
          // ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(AppImageAssets.userAvatar),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feedResponse.name ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      timeAgo,
                      style: TextStyle(fontSize: 12, color: AppColors.textColorGray),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.more_vert),
              ],
            ),
            const SizedBox(height: 5),
            Container(
              height: 1,
              color: AppColors.darkerGray,
              width: MediaQuery.of(context).size.width,
            ),
            const SizedBox(height: 5),

            feedResponse.isBackground == 0 ? textFeed(feedResponse) : const SizedBox(),
            const SizedBox(height: 10),
            // Example image for alternating items
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: feedResponse.isBackground == 1
                    ? ColorConstantLinear.findIndex(feedResponse.bgColor) != -1
                        ? ColorConstantLinear.gradientsColor[ColorConstantLinear.findIndex(feedResponse.bgColor)]
                        : null
                    : null,
              ),
              child: feedResponse.isBackground == 0
                  ? CachedNetworkImage(
                      imageUrl: feedResponse.pic ?? "",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // placeholder: (context, url) {
                      //   return Image.asset(
                      //     AppImageAssets.angry,
                      //     fit: BoxFit.cover,
                      //     width: double.infinity,
                      //   );
                      // },
                      // errorWidget: (context, url, error) {
                      //   return Image.asset(
                      //     AppImageAssets.angry,
                      //     fit: BoxFit.cover,
                      //     width: double.infinity,
                      //   );
                      // },
                    )
                  : Center(child: textFeed(feedResponse)),
            ),

            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      makeLike(),
                      Transform.translate(offset: const Offset(-5, 0), child: makeLove()),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "100",
                        style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                      )
                    ],
                  ),
                  buildReactionsIcon(
                    AppImageAssets.commentRegular,
                    Text(
                      '${feedResponse.commentCount} Comments',
                      style: const TextStyle(
                        color: AppColors.textColorBlack,
                      ),
                    ),
                  )

                  // Text(
                  //   "No Comments",
                  //   style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ReactionButton<String>(
                    itemSize: const Size.square(40),
                    onReactionChanged: (Reaction<String>? reaction) {
                      //do api call here
                    },
                    reactions: reactions,
                    // placeholder: rtnindex != -1 ? reactions[rtnindex] : defaultInitialReaction,
                    selectedReaction: reactions.first,
                  ),
                ),
                buildReactionsIcon(
                  AppImageAssets.commentFilled,
                  const Text(
                    'Comment',
                    style: TextStyle(
                      color: Color(0XFF000000),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget textFeed(FeedResponse feedResponse) {
    return Text(
      feedResponse.feedTxt ?? "",
      style: const TextStyle(fontSize: 14),
    );
  }
}

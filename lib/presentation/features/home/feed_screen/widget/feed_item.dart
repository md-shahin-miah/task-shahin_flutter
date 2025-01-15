import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:shahin_appify_task/core/constants/color_constant_linear.dart';
import 'package:shahin_appify_task/core/constants/image_assets.dart';
import 'package:shahin_appify_task/core/utils/utils.dart';
import 'package:shahin_appify_task/domain/model/common/meta_data.dart';
import 'package:shahin_appify_task/domain/model/feed/feed_response.dart';
import 'package:shahin_appify_task/domain/model/feed/like.dart';
import 'package:shahin_appify_task/domain/model/feed/like_type.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/widget/comment_bottom_sheet.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/widget/horizontal_reaction_list.dart';

import '../../../../../core/themes/styles/app_colors.dart';
import '../../../../../data/network/models/network_request/create_delete_reaction_request.dart';
import '../../../../../data/network/models/network_response/feed_response.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../widgets/button/reactions.dart';
import '../feeds_screen_view_model.dart';

final stateChangeCheck = StateProvider((ref) => 0);

class FeedItem extends StatelessWidget {
  final FeedResponse feedResponse;
  Reaction<String>? reactionCu;

  FeedItem(this.feedResponse, {super.key});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(feedResponse.createdAt.toString());
    final timeAgo = timeago.format(dateTime);
    var like = feedResponse.like?.reactionType ?? "";
    var selectedIndexReact = getSelectedIndex(like ?? "");
    print("---------dsdsds ---->");
    var youTxt = selectedIndexReact.isNegative
        ? ""
        : reactions.length > 2
            ? "You and ${reactions.length} other"
            : "You likes this";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
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
                      style: const TextStyle(
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

            feedResponse.isBackground == 0 ? Container(margin: const EdgeInsets.only(top: 2), child: textFeed(feedResponse)) : const SizedBox(),
            const SizedBox(height: 10),
            // Example image for alternating items
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: feedResponse.isBackground == 1
                    ? ColorConstantLinear.findIndex(feedResponse.bgColor ?? "") != -1
                        ? ColorConstantLinear.gradientsColor[ColorConstantLinear.findIndex(feedResponse.bgColor ?? "")]
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
                      feedResponse.likeCount != null
                          ? feedResponse.likeCount! > 0
                              ? SizedBox(
                                  height: 25,
                                  child: DynamicItemDisplay(reactions: getListSelectedReactions(feedResponse.likeType), title: youTxt),
                                )
                              : const SizedBox()
                          : const SizedBox(),
                    ],
                  ),
                  buildReactionsIcon(
                    AppImageAssets.commentRegular,
                    Text(
                      '${feedResponse.commentCount} Comments',
                      style: const TextStyle(
                        color: AppColors.textColorBlack2,
                      ),
                    ),
                  )
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
                  child: Consumer(builder: (context, ref, child) {
                    print("------dd------->");
                    var likeTemp = feedResponse.like?.reactionType ?? "";
                    var selectedIndexReactTemp = getSelectedIndex(likeTemp ?? "");

                    if (selectedIndexReactTemp > -1) {
                      reactionCu = reactions.elementAt(selectedIndexReactTemp);
                    }

                  final val=  selectedIndexReactTemp > -1
                        ? reactionCu != null
                        ? reactionCu!
                        : defaultInitiaCommentReaction
                        : defaultInitiaCommentReaction;

                    print("----afdaw adsafsa-----$val---->");

                    return ReactionButton<String>(
                      itemSize: const Size.square(40),
                      onReactionChanged: (Reaction<String>? reaction) {
                        var value = reaction?.value;

                        print("--------feedResponse-------->${feedResponse.like == value?.toUpperCase()}");
                        if (feedResponse.like == value) {
                          feedResponse.like = null;
                        } else {
                          feedResponse.like = Like(
                              reactionType: value?.toUpperCase(),
                              id: 0,
                              createdAt: DateTime.now(),
                              feedId: feedResponse.id,
                              updatedAt: DateTime.now(),
                              meta: MetaDataClass(json: {}),
                              userId: feedResponse.userId,
                              isAnonymous: 0);
                        }

                        value ??= feedResponse.like?.reactionType;
                        value ??= "Like";
                        print("---------reaction------->$value  ${getData(feedResponse.likeType, value)}    $value");
                        ref.read(createOrDeleteReactionStateNotifierProvider.notifier).createOrDeleteReaction(
                            CreateOrDeleteReactionRequest(feed_id: feedResponse.id.toString(), action: "deleteOrCreate", reaction_type: value.toUpperCase(), reactionSource: "COMMUNITY"));
                      },
                      reactions: reactions,
                      selectedReaction: val,
                      placeholder: val,

                    );
                  }),
                ),
                Consumer(
                  builder: (context, ref, child) => InkWell(
                    onTap: () {
                      // ref.invalidate(replyStateProvider);
                      controllerComment.text = "";
                      controllerReply.text = "";
                      ref.invalidate(selectedReplyIndex);
                      showCommentBottomSheet(context, feedResponse, youTxt, selectedIndexReact);
                    },
                    child: buildReactionsIcon(
                      AppImageAssets.commentFilled,
                      const Text(
                        'Comment',
                        style: TextStyle(
                          color: Color(0XFF000000),
                        ),
                      ),
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
    return LinkifyText(
      feedResponse.feedTxt ?? "",
      linkStyle: const TextStyle(color: Colors.blue),
      textStyle: const TextStyle(fontSize: 14),
      onTap: (link) {
        if (link.type == LinkType.url) {
          Utils.loadUrl(link.value);
        }
      },
    );
  }

  bool getData(List<LikeType> likeTypes, String reaction) {
    return likeTypes.map((item) => item.reactionType).contains(reaction);
  }
}

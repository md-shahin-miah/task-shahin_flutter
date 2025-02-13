import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_reply_request.dart';
import 'package:shahin_appify_task/domain/model/comments/comment_response.dart';
import 'package:shahin_appify_task/data/network/models/network_response/reply_response.dart';
import 'package:shahin_appify_task/domain/model/feed/feed_response.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/widget/reply_item_widget.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/feeds_screen_view_model.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/widget/comment_bottom_sheet.dart';
import 'package:shahin_appify_task/presentation/widgets/button/reactions.dart';
import 'package:shahin_appify_task/presentation/widgets/shimmer/reply_shimmer.dart';
import 'package:shahin_appify_task/presentation/widgets/text_field/custom_text_field.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../common/constants/image_assets.dart';
import '../../../../../common/themes/styles/app_colors.dart';

class CommentItem extends ConsumerWidget {
  final CommentResponse comment;

  int commentIndex;

  CommentItem({required this.comment, required this.commentIndex, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime dateTime = DateTime.parse(comment.createdAt.toString());
    final timeAgo = timeago.format(dateTime);

    int rtnindex = -1;
    return Padding(
      padding: EdgeInsets.only(left: comment.replies.isNotEmpty ? 60 : 0, bottom: 8.0),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    margin: EdgeInsets.only(bottom: 25),
                    child: CachedNetworkImage(
                      imageUrl:comment.user?.profilePic??"",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) {
                        return Image.asset(
                          AppImageAssets.userAvatar,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Image.asset(
                          AppImageAssets.userAvatar,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 25, top: 8, bottom: 8),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: AppColors.fillColor2, borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(comment.user?.fullName ?? "", style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                                    Text(comment.commentTxt ?? "", style: const TextStyle(fontSize: 14.0, color: Colors.black)),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.more_horiz, size: 20.0),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Text(timeAgo, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                              const SizedBox(width: 20.0),
                              ReactionButton<String>(
                                itemSize: const Size.square(40),
                                onReactionChanged: (Reaction<String>? reaction) {},
                                reactions: reactions,
                                placeholder: rtnindex != -1 ? reactions[rtnindex] : defaultInitialReaction,
                                selectedReaction: reactions.first,
                                child: const Text("Like", style: TextStyle(fontSize: 12, color: Colors.blue)),
                              ),
                              const SizedBox(width: 20.0),
                              InkWell(
                                  onTap: () {
                                    controllerComment.text = "";
                                    ref.read(selectedReplyIndex.notifier).state = ref.read(selectedReplyIndex) == commentIndex ? -1 : commentIndex;
                                  },
                                  child:
                                      ref.watch(selectedReplyIndex) == commentIndex ? const Text("Cancel reply", style: TextStyle(fontSize: 12)) : const Text("Reply", style: TextStyle(fontSize: 12))),
                              const Spacer(),
                              if (comment.replies.isNotEmpty) Text("${comment.replies.length}", style: const TextStyle(fontSize: 12, color: Colors.blue)),
                              const SizedBox(
                                width: 5,
                              ),
                              Image.asset(AppImageAssets.like, height: 15),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 50),
                child: ref.watch(replyFutureProvider(comment.id.toString())).when(data: (data) {
                  ReplyResponseList? replyData = data;

                  if (replyData?.replyResponseList != null) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: replyData?.replyResponseList.length,
                      itemBuilder: (context, index) {
                        return ReplyItem(reply: replyData!.replyResponseList[index]);
                      },
                    );
                  } else {
                    return Container();
                  }
                }, error: (error, stackTrace) {
                  return Container();
                }, loading: () {
                  return const ReplyShimmer();
                }),
              ),
              ref.watch(selectedReplyIndex) == commentIndex
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 5, left: 50),
                      height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.darkerGray,width: 1),
                    borderRadius: const BorderRadius.all(
                Radius.circular(4.0) //                 <--- border radius here
              )
                ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Consumer(builder: (context, ref, child) {
                              return CustomTextField(
                                isBorder: false,
                                hintText: 'Write a reply',
                                hintColor: AppColors.lightGray,
                                controller: controllerReply,
                                isPassword: false,
                              );
                            }),
                          ),
                          Expanded(
                            flex: 1,
                            child: Consumer(
                              builder: (context, ref, child) => InkWell(
                                onTap: () {

                                  ref.read(createReplyStateNotifierProvider.notifier).createReply(CreateReplyRequest(
                                      comment_txt: controllerReply.text,
                                      feed_id: comment.feedId.toString(),
                                      feed_user_id: comment.userId.toString(),
                                      parrent_id: comment.id.toString(),
                                      commentSource: "COMMUNITY"));

                                  controllerReply.text = "";
                                },
                                child: Container(
                                  height: double.infinity,
                                  padding: const EdgeInsets.only(right: 8),
                                  decoration: const BoxDecoration(color: AppColors.darkerGray, borderRadius: BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4))),
                                  child: ref.watch(createReplyStateNotifierProvider).maybeWhen(
                                    orElse: () {
                                      return const Center(child: Text("Reply", style: TextStyle(color: AppColors.white)));
                                    },
                                    loading: () {
                                      return const Center(child: SizedBox(height: 16, width: 16, child: CircularProgressIndicator(color: AppColors.primaryColor)));
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}

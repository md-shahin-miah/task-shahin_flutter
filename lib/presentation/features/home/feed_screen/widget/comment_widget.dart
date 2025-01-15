import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shahin_appify_task/core/constants/image_assets.dart';
import 'package:shahin_appify_task/core/themes/styles/app_colors.dart';
import 'package:shahin_appify_task/domain/model/comments/comment_response.dart';
import 'package:shahin_appify_task/data/network/models/network_response/reply_response.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/widget/reply_widget.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/feeds_screen_view_model.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/widget/comment_bottom_sheet.dart';
import 'package:shahin_appify_task/presentation/widgets/button/reactions.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentWidget extends ConsumerWidget {
  final CommentResponse comment;

  const CommentWidget({required this.comment, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime dateTime = DateTime.parse(comment.createdAt.toString());
    final timeAgo = timeago.format(dateTime);

    int rtnindex = -1;
    return Padding(
      padding: EdgeInsets.only(left: comment.replies.isNotEmpty ? 60 : 0, bottom: 8.0),
      child: Stack(
        children: [
          if (comment.replyCount != 0)
            Positioned(
              left: 26,
              top: 40,
              child: SizedBox(
                width: 20,
                height: 50,
                child: CustomPaint(
                  painter: CurvedLinePainter(),
                ),
              ),
            ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    child: CircleAvatar(radius: comment.replies.isNotEmpty ? 20 : 30),
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
                              GestureDetector(
                                  onTap: () {
                                    controllerCommentReply.text = "";

                                    ref.read(replyStateProvider.notifier).state = comment.id.toString();
                                  },
                                  child: const Text("Reply", style: TextStyle(fontSize: 12))),
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
              ref.watch(replyFutureProvider(comment.id.toString())).when(data: (data) {
                ReplyResponseList? replyData = data;

                if (replyData?.replyResponseList != null) {
                  return Container(
                    margin: const EdgeInsets.only(left: 50),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: replyData?.replyResponseList.length,
                      itemBuilder: (context, index) {
                        return ReplyWidget(comment: replyData!.replyResponseList[index]);
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              }, error: (error, stackTrace) {
                return Container();
              }, loading: () {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            width: 22,
                            height: 22,
                            padding: const EdgeInsets.only(bottom: 5),
                            child: const CircularProgressIndicator(
                              strokeWidth: 1.5,
                              color: AppColors.primaryColor,
                            ),
                          )),
                    ),
                    const Text('Loading comments'),
                  ],
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}

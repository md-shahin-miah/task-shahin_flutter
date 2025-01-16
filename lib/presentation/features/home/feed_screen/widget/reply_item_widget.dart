import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shahin_appify_task/core/constants/image_assets.dart';
import 'package:shahin_appify_task/core/themes/styles/app_colors.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_reply_request.dart';
import 'package:shahin_appify_task/domain/model/reply/reply_response.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/feeds_screen_view_model.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/widget/comment_bottom_sheet.dart';
import 'package:timeago/timeago.dart' as timeago;

class ReplyItem extends ConsumerWidget {
  final ReplyResponse comment;


  ReplyItem({required this.comment, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime dateTime = DateTime.parse(comment.createdAt.toString());
    final timeAgo = timeago.format(dateTime);

    int rtnindex = -1;
    return Padding(
      padding: EdgeInsets.only(left: comment.replies.isNotEmpty ? 60 : 0, bottom: 8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: CircleAvatar(radius: comment.replies.isNotEmpty ? 20 : 20),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 25, top: 8, bottom: 0),
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
                          const SizedBox(
                            width: 14,
                          ),
                          Text(timeAgo, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                          const SizedBox(width: 20.0),
                          const Spacer(),
                          if (comment.replies.isNotEmpty) Text("${comment.replies.length}", style: const TextStyle(fontSize: 12, color: Colors.blue)),
                          const SizedBox(
                            width: 5,
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
        ],
      ),
    );
  }
}

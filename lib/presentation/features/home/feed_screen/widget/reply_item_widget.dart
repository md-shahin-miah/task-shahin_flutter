import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shahin_appify_task/domain/model/reply/reply_response.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../common/constants/image_assets.dart';
import '../../../../../common/themes/styles/app_colors.dart';

class ReplyItem extends ConsumerWidget {
  final ReplyResponse reply;


  ReplyItem({required this.reply, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime dateTime = DateTime.parse(reply.createdAt.toString());
    final timeAgo = timeago.format(dateTime);

    return Padding(
      padding: EdgeInsets.only(left: reply.replies.isNotEmpty ? 60 : 0, bottom: 8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 60,
                margin: EdgeInsets.only(bottom: 25),
                child: CachedNetworkImage(
                  imageUrl:reply.user?.profilePic??"",
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
                      padding: const EdgeInsets.only(left: 25, top: 8, bottom: 0),
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(color: AppColors.fillColor2, borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(reply.user?.fullName ?? "", style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                                Text(reply.commentTxt ?? "", style: const TextStyle(fontSize: 14.0, color: Colors.black)),
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
                          if (reply.replies.isNotEmpty) Text("${reply.replies.length}", style: const TextStyle(fontSize: 12, color: Colors.blue)),
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

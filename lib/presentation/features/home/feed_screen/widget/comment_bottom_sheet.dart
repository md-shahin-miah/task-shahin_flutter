import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:shahin_appify_task/core/constants/image_assets.dart';
import 'package:shahin_appify_task/core/themes/styles/app_colors.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_comment_request.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_reply_request.dart';
import 'package:shahin_appify_task/data/network/models/network_response/comment_response.dart';
import 'package:shahin_appify_task/data/network/models/network_response/comment_response_list.dart';
import 'package:shahin_appify_task/data/network/models/network_response/feed_response.dart';
import 'package:shahin_appify_task/data/network/models/network_response/reply_response.dart';
import 'package:shahin_appify_task/data/state/data_state.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/feeds_screen_view_model.dart';
import 'package:shahin_appify_task/presentation/widgets/common/custom_text_field.dart';
import 'package:shahin_appify_task/presentation/widgets/common/reactions.dart';
import 'package:timeago/timeago.dart' as timeago;

final replyStateProvider = StateProvider((ref) => "");

void showCommentBottomSheet(
    BuildContext context, FeedResponse feedResponse, String title) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) =>
        CommentBottomSheet(feedResponse: feedResponse, title: title),
  );
}

class CommentBottomSheet extends ConsumerWidget {
  FeedResponse? feedResponse;

  CommentResponseList? commentData;
  String title;

  CommentBottomSheet(
      {required this.feedResponse, required this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    observer(ref, context);
    final size = MediaQuery.of(context).size;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    print("---------keyboardHeight---->$keyboardHeight");
    return Container(
      margin: const EdgeInsets.only(top: 100),
      padding: const EdgeInsets.only(
          top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                const Icon(Icons.favorite, color: Colors.red, size: 18),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            flex: keyboardHeight == 0 ? 4 : 1,
            child: Consumer(builder: (context, ref, child) {
              return ref
                  .watch(commentFutureProvider(feedResponse!.id.toString()!))
                  .when(data: (data) {
                CommentResponseList? commentData = data;

                return ListView.builder(
                  itemCount: commentData?.commentResponseList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        ref.invalidate(replyStateProvider);
                      },
                      child: CommentWidget(
                          comment: commentData!.commentResponseList[index]),
                    );
                  },
                );
              }, error: (error, stackTrace) {
                return Text('Something went wrong');
              }, loading: () {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              color: AppColors.primary,
                            ),
                          )),
                    ),
                    Text('Loading comments'),
                  ],
                );
              });
            }),
          ),
          _buildCommentTextField(feedResponse!),
          Expanded(
            flex: keyboardHeight == 0 ? 0 : 1,
            child: Container(),
          )
        ],
      ),
    );
  }

  void observer(WidgetRef ref, BuildContext context) {
    ref.listen<DataState>(createCommentStateNotifierProvider, (_, state) {
      state.maybeWhen(
        success: (user) {
          print("-------createCommentStateNotifierProvider--------->");
          ref.invalidate(commentFutureProvider);
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
    ref.listen<DataState>(createReplyStateNotifierProvider, (_, state) {
      state.maybeWhen(
        success: (user) {
          print("-------createReplyStateNotifierProvider--------->");
          ref.invalidate(commentFutureProvider);

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

class CommentWidget extends ConsumerWidget {
  final CommentResponse comment;

  const CommentWidget({required this.comment, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime dateTime = DateTime.parse(comment.createdAt.toString());
    final timeAgo = timeago.format(dateTime);

    int rtnindex = -1;
    return Padding(
      padding: EdgeInsets.only(
          left: comment.replies.isNotEmpty ? 60 : 0, bottom: 8.0),
      child: Stack(
        children: [
          if (comment.replies.isNotEmpty)
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
                    child: CircleAvatar(
                        radius: comment.replies.isNotEmpty ? 20 : 30),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 25, top: 8, bottom: 8),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppColors.fillColor2,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(comment.user?.fullName ?? "",
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold)),
                                    Text(comment.commentTxt ?? "",
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black)),
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
                              Text(timeAgo,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600)),
                              const SizedBox(width: 20.0),
                              ReactionButton<String>(
                                itemSize: const Size.square(40),
                                onReactionChanged:
                                    (Reaction<String>? reaction) {},
                                reactions: reactions,
                                child: Text("Like",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.blue)),
                                placeholder: rtnindex != -1
                                    ? reactions[rtnindex]
                                    : defaultInitialReaction,
                                selectedReaction: reactions.first,
                              ),
                              const SizedBox(width: 20.0),
                              GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(replyStateProvider.notifier)
                                        .state = comment.id.toString();
                                  },
                                  child: const Text("Reply",
                                      style: TextStyle(fontSize: 12))),
                              const Spacer(),
                              if (comment.replies.isNotEmpty)
                                Text("${comment.replies.length}",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.blue)),
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
              ref.watch(replyFutureProvider(comment!.id.toString())).when(
                  data: (data) {
                ReplyResponseList? replyData = data;

                if (replyData?.replyresponsList != null) {
                  return Container(
                    margin: EdgeInsets.only(left: 50),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: replyData?.replyresponsList.length,
                      itemBuilder: (context, index) {
                        return ReplyWidget(
                            comment: replyData!.replyresponsList[index]);
                      },
                    ),
                  );
                } else {
                  return Text('Something went wrong');
                }
              }, error: (error, stackTrace) {
                return Text('Something went wrong');
              }, loading: () {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              color: AppColors.primary,
                            ),
                          )),
                    ),
                    Text('Loading comments'),
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

class ReplyWidget extends ConsumerWidget {
  final ReplyResponse comment;

  const ReplyWidget({required this.comment, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime dateTime = DateTime.parse(comment.createdAt.toString());
    final timeAgo = timeago.format(dateTime);

    int rtnindex = -1;
    return Padding(
      padding: EdgeInsets.only(
          left: comment.replies.isNotEmpty ? 60 : 0, bottom: 8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child:
                    CircleAvatar(radius: comment.replies.isNotEmpty ? 20 : 20),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(left: 25, top: 8, bottom: 8),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.fillColor2,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(comment.user?.fullName ?? "",
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold)),
                                Text(comment.commentTxt ?? "",
                                    style: const TextStyle(
                                        fontSize: 14.0, color: Colors.black)),
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
                          Text(timeAgo,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade600)),
                          const SizedBox(width: 20.0),
                          ReactionButton<String>(
                            itemSize: const Size.square(40),
                            onReactionChanged: (Reaction<String>? reaction) {},
                            reactions: reactions,
                            child: Text("Like",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.blue)),
                            placeholder: rtnindex != -1
                                ? reactions[rtnindex]
                                : defaultInitialReaction,
                            selectedReaction: reactions.first,
                          ),
                          const SizedBox(width: 20.0),
                          GestureDetector(
                              onTap: () {},
                              child: const Text("Reply",
                                  style: TextStyle(fontSize: 12))),
                          const Spacer(),
                          if (comment.replies.isNotEmpty)
                            Text("${comment.replies.length}",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.blue)),
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
        ],
      ),
    );
  }
}

Widget _buildCommentTextField(FeedResponse feedResponse) {
  final _conWriteHere = TextEditingController();
  return Container(
    height: 50,
    margin: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: AppColors.fillColor3,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: const Icon(Icons.person, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 4,
          child: Consumer(builder: (context, ref, child) {
            var txt = ref.watch(replyStateProvider) == "" ? "Comment" : "Reply";
            return CustomTextField(
              isBorder: false,
              hintText: 'Write a $txt',
              hintColor: AppColors.lightGray,
              controller: _conWriteHere,
              isPassword: false,
            );
          }),
        ),
        Expanded(
          flex: 1,
          child: Consumer(
            builder: (context, ref, child) => InkWell(
              onTap: () {
                print("-----ss------>");

                if (ref.read(replyStateProvider) == "") {
                  ref
                      .read(createCommentStateNotifierProvider.notifier)
                      .createComment(CreateCommentRequest(
                          comment_txt: _conWriteHere.text,
                          feed_id: feedResponse.id.toString(),
                          feed_user_id: feedResponse.userId.toString(),
                          commentSource: "COMMUNITY"));
                } else {
                  ref
                      .read(createReplyStateNotifierProvider.notifier)
                      .createReply(CreateReplyRequest(
                          comment_txt: _conWriteHere.text,
                          feed_id: feedResponse.id.toString(),
                          feed_user_id: feedResponse.userId.toString(),
                          parent_id: ref.read(replyStateProvider),
                          commentSource: "COMMUNITY"));
                }
              },
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.only(right: 8),
                decoration: const BoxDecoration(
                    color: AppColors.primaryDark,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Image.asset(AppImageAssets.sendArrow, width: 24),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class Comment {
  final String author;
  final String content;
  final bool isNested;
  final List<Comment> replies;

  Comment(
      {required this.author,
      required this.content,
      this.isNested = false,
      this.replies = const []});
}

class CurvedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(4, 0)
      ..lineTo(4, size.height + 60)
      ..quadraticBezierTo(
        0,
        size.height + 60,
        size.width + 45,
        size.height + 60,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

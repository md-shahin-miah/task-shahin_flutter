import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_comment_request.dart';
import 'package:shahin_appify_task/data/network/models/network_response/comment_response_list.dart';
import 'package:shahin_appify_task/data/state/data_state.dart';
import 'package:shahin_appify_task/domain/model/feed/feed_response.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/widget/comment_item_widget.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/feeds_screen_view_model.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/widget/horizontal_reaction_list.dart';
import 'package:shahin_appify_task/presentation/widgets/shimmer/comment_shimmer.dart';
import 'package:shahin_appify_task/presentation/widgets/text_field/custom_text_field.dart';

import '../../../../../common/constants/image_assets.dart';
import '../../../../../common/themes/styles/app_colors.dart';
import '../../../../../common/utils/snackbar/snackbar_service.dart';
import '../../../../widgets/button/reactions.dart';

final controllerComment = TextEditingController();
final controllerReply = TextEditingController();
final selectedReplyIndex = StateProvider((ref) => -1);

void showCommentBottomSheet(BuildContext context, FeedResponse feedResponse, String title, int selectedIndexReact) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => CommentBottomSheet(
      feedResponse: feedResponse,
      title: title,
    ),
  );
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

class CommentBottomSheet extends ConsumerWidget {
  FeedResponse? feedResponse;

  CommentResponseList? commentData;
  String title;

  CommentBottomSheet({required this.feedResponse, required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    observer(ref, context);
    final size = MediaQuery.of(context).size;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    print("---------keyboardHeight---->$keyboardHeight");
    return Container(
      margin: const EdgeInsets.only(top: 100),
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Consumer(
              builder: (context, ref, child) {
                return ref
                    .watch(reactionFutureProvider(
                    feedResponse!.id.toString()))
                    .when(data: (data) {
                  if (data?.reactions != null) {
                    var tempText=data!.reactions.isNotEmpty?"${data.reactions.length} likes this ":"";
                    return SizedBox(
                      height: 25,
                      child: DynamicItemDisplay(
                          reactions: getListSelectedReactionsss(
                              data.reactions),
                          title: tempText),
                    );
                  } else {
                    return Container();
                  }
                }, error: (e, str) {
                  return Container();
                }, loading: () {
                  return Container();
                });
              },
            )

          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            flex: keyboardHeight == 0 ? 4 : 1,
            child: Consumer(builder: (context, ref, child) {
              return ref.watch(commentFutureProvider(feedResponse!.id.toString())).when(data: (data) {
                CommentResponseList? commentData = data;

                return ListView.builder(
                  itemCount: commentData?.commentResponseList.length,
                  itemBuilder: (context, index) {
                    return CommentItem(comment: commentData!.commentResponseList[index], commentIndex: index);
                  },
                );
              }, error: (error, stackTrace) {
                return const Text('Something went wrong');
              }, loading: () {
                return const CommentShimmer();
              });
            }),
          ),
          _buildCommentTextField(feedResponse!),
          Expanded(
            flex: ref.watch(selectedReplyIndex) > -1
                ? 0
                : keyboardHeight == 0
                    ? 0
                    : 1,
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
          ref.invalidate(replyFutureProvider);
          ref.invalidate(selectedReplyIndex);

          controllerComment.text = "";
        },
        error: (err, _) {
          debugPrint(err);
          ToastService.showToast(title: err, backgroundColor: AppColors.colorError);
        },
        orElse: () {},
      );
    });
    ref.listen<DataState>(createReplyStateNotifierProvider, (_, state) {
      state.maybeWhen(
        success: (user) {
          controllerReply.text = "";
          print("-------createReplyStateNotifierProvider--------->");
          ref.invalidate(commentFutureProvider);
          ref.invalidate(feedFutureProvider);
          ref.invalidate(replyFutureProvider);
          ref.invalidate(selectedReplyIndex);
        },
        error: (err, _) {
          debugPrint(err);
          ToastService.showToast(title: err, backgroundColor: AppColors.colorError);
        },
        orElse: () {},
      );
    });
  }

  Widget _buildCommentTextField(FeedResponse feedResponse) {
    // var txt = ref.watch(replyStateProvider) == "" ? "Comment" : "Reply"
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.fillColor3,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Consumer(
        builder: (context, ref, child) => Column(
          children: [
            SizedBox(
              height: 50,
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
                      return FocusScope(


                        child: Focus(
                          onFocusChange: (focus){
                            if(focus){
                              ref.invalidate(selectedReplyIndex);
                            }

                          },

                          child: CustomTextField(
                            isBorder: false,
                            hintText: 'Write a comment',
                            hintColor: AppColors.lightGray,
                            controller: controllerComment,
                            isPassword: false,
                          ),
                        ),
                      );
                    }),
                  ),
                  Expanded(
                    flex: 1,
                    child: Consumer(
                      builder: (context, ref, child) => InkWell(
                        onTap: () {
                          ref.invalidate(selectedReplyIndex);
                          ref.read(createCommentStateNotifierProvider.notifier).createComment(
                              CreateCommentRequest(comment_txt: controllerComment.text, feed_id: feedResponse.id.toString(), feed_user_id: feedResponse.userId.toString(), commentSource: "COMMUNITY"));
                          controllerComment.text = "";
                        },
                        child: Container(
                          height: double.infinity,
                          padding: const EdgeInsets.only(right: 8),
                          decoration: const BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30))),
                          child: ref.watch(createCommentStateNotifierProvider).maybeWhen(
                            orElse: () {
                              return Image.asset(AppImageAssets.sendArrow, width: 24);
                            },
                            loading: () {
                              return const Center(child: SizedBox(height: 16, width: 16, child: CircularProgressIndicator(color: AppColors.white)));
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

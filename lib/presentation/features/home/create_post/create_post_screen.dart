import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shahin_appify_task/core/constants/color_constant_linear.dart';
import 'package:shahin_appify_task/core/routes/go_route_context_extension.dart';
import 'package:shahin_appify_task/core/utils/snackbar/snackbar_service.dart';
import 'package:shahin_appify_task/data/state/data_state.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/feeds_screen_view_model.dart';

import '../../../../core/themes/styles/app_colors.dart';
import '../../../../data/network/models/network_request/create_post_request.dart';

final selectedGradiant = StateProvider((ref) => 0);

class CreatePostScreen extends ConsumerWidget {
  final TextEditingController _textController = TextEditingController();

  final TextAlign _textAlign = TextAlign.start;
  final FontWeight _fontWeight = FontWeight.normal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    observer(ref, context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leadingWidth: 80,
        leading: TextButton(
          onPressed: () {
            context.pop();
            ref.invalidate(selectedGradiant);
          },
          child: const Text(
            "Close",
            style: TextStyle(color: AppColors.darkerGray, fontSize: 16),
          ),
        ),
        title: const Text(
          "Create Post",
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        centerTitle: true,
        actions: [
          Consumer(
              builder: (context, ref, child) => ref
                      .watch(createFeedStateNotifierProvider)
                      .maybeWhen(orElse: () {
                    return TextButton(
                      onPressed: () {

                        if(_textController.text.isNotEmpty){
                          ref
                              .read(createFeedStateNotifierProvider.notifier)
                              .createPost(CreatePostRequest(
                              community_id: "2914",
                              space_id: "5883",
                              activity_type: "group",
                              bg_color: ref.read(selectedGradiant) > 0
                                  ? ColorConstantLinear
                                  .feedBackGroundGradientColors[
                              ref.read(selectedGradiant)]
                                  : "",
                              feed_txt: _textController.text,
                              is_background:
                              ref.read(selectedGradiant) > 0 ? 1 : 0,
                              uploadType: "text"));
                        }
                        else{
                          SnackBarService.showSnackBar(title: "Text required", backgroundColor: AppColors.colorError);


                        }


                      },
                      child: const Text(
                        "Create",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }, loading: () {
                    return Container(
                        height: 20,
                        width: 20,
                        margin: EdgeInsets.only(right: 10),
                        child:
                            const CircularProgressIndicator(color: Colors.red));
                  })),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: GradientTextContainer(
                controller: _textController,
                textAlign: _textAlign,
                fontWeight: _fontWeight,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: GradientColorSelector(
                gradients: ColorConstantLinear.gradientsColor,

                onToggleList: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  void observer(WidgetRef ref, BuildContext context) {
    ref.listen<DataState>(createFeedStateNotifierProvider, (_, state) {
      state.maybeWhen(
        success: (user) {
          print("-------createCommentStateNotifierProvider--------->");
          ref.invalidate(feedFutureProvider);
          context.pop();
        },
        error: (err, _) {
          debugPrint(err);
          SnackBarService.showSnackBar(title: err, backgroundColor: AppColors.colorError);

        },
        orElse: () {},
      );
    });
  }
}

class GradientTextContainer extends StatelessWidget {
  final TextEditingController controller;
  final TextAlign textAlign;
  final FontWeight fontWeight;

  const GradientTextContainer({
    required this.controller,
    required this.textAlign,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => Container(
        padding: const EdgeInsets.all(10),
        alignment: textAlign == TextAlign.center
            ? Alignment.center
            : Alignment.topLeft,
        decoration: BoxDecoration(
          gradient:
              ColorConstantLinear.gradientsColor[ref.watch(selectedGradiant)],
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          controller: controller,
          minLines: textAlign == TextAlign.center ? 1 : 7,
          maxLines: 7,
          textAlign: textAlign,
          style: TextStyle(fontWeight: fontWeight),
          decoration: const InputDecoration(
            hintText: "What's on your mind?",
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class GradientColorSelector extends StatelessWidget {
  final List gradients;

  // final List<Color> selectedGradient;
  final VoidCallback onToggleList;

  const GradientColorSelector({
    required this.gradients,
    // required this.selectedGradient,
    required this.onToggleList,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onToggleList,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: gradients.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 5),
                  itemBuilder: (context, index) {
                    return Consumer(
                      builder: (context, ref, child) => GestureDetector(
                        onTap: () {
                          ref.read(selectedGradiant.notifier).state = index;
                          // onGradientSelected(gradients[index], index != 0);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: gradients[index],
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color:
                                  gradients[index] == ref.read(selectedGradiant)
                                      ? Colors.blue
                                      : Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}

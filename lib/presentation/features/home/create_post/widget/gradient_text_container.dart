import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shahin_appify_task/core/constants/color_constant_linear.dart';
import 'package:shahin_appify_task/presentation/features/home/create_post/create_post_screen.dart';

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


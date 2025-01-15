import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/themes/styles/app_colors.dart';

class FeedShimmer extends StatelessWidget {
  const FeedShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 27),
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              ),
              const SizedBox(
                height: 40,
              ),
              ...List.generate(4, (index) {
                return Column(
                  children: [
                    Container(
                      height: 300,
                      color: Colors.white,
                    ),
                    Container(
                      height: 30,
                      color: Colors.transparent,
                    ),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

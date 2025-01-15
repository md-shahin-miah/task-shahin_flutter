import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/themes/styles/app_colors.dart';

class ReplyShimmer extends StatelessWidget {
  const ReplyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 27),
        child: Column(
          children: [
            ...List.generate(1, (index) {
              return Column(

                children: [
                  Container(
                  height: 10,
                ),
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
                      ),
                      Container(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                color: Colors.white,
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 5,
                  )
                ],
              );
            })
          ],
        ),
      ),
    ));
  }
}

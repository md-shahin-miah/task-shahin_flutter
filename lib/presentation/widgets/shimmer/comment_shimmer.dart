import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/themes/styles/app_colors.dart';

class CommentShimmer extends StatelessWidget {
  const CommentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(

          children: [

            ...List.generate(4, (index) {
              return Column(
                children: [
                  Container(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 75,
                        width: 75,
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
                                height: 30,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 20,
                                alignment: Alignment.centerLeft,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 20,
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

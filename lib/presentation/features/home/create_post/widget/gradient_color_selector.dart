import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shahin_appify_task/presentation/features/home/create_post/create_post_screen.dart';

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
          InkWell(
            onTap: onToggleList,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(0),
              ),
              child: const Icon(
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
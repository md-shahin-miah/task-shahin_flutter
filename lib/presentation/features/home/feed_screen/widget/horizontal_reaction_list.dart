import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

class DynamicItemDisplay extends StatelessWidget {
  final List<Reaction<String>> reactions;

  final String title;

  DynamicItemDisplay({Key? key, required this.reactions, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("------title----->$title");
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: List.generate(reactions.length, (index) {
            final item = reactions[index];
            double vas = index * 5;
            Widget itemWidget = Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
              ),
              child: Center(
                child: reactions[index].previewIcon,
              ),
            );

            if (index == 0) {
              itemWidget = Transform.translate(
                offset: const Offset(0, 0),
                child: itemWidget,
              );
            } else if (index > 0) {
              itemWidget = Transform.translate(
                offset: Offset((-vas), 0),
                child: itemWidget,
              );
            }
            return itemWidget;
          }),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 13, color: Colors.grey[800]),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:shahin_appify_task/core/constants/image_assets.dart';
import 'package:shahin_appify_task/core/themes/styles/app_colors.dart';
import 'package:shahin_appify_task/domain/model/feed/like_type.dart';

final defaultInitialReaction = Reaction<String>(
  value: null,
  icon: buildReactionsIcon(
    AppImageAssets.unLike,
    const Text(
      'Like',
      style: TextStyle(
        color: Color(0XFF000000),
      ),
    ),
  ),
);

final defaultInitiaCommentReaction = Reaction<String>(
  value: null,
  icon: buildReactionsIcon(
    AppImageAssets.unLike,
    const Text(
      'Like',
      style: TextStyle(fontSize: 16, color: AppColors.black),
    ),
  ),
);
final List<Reaction<String>> reactions = [
  Reaction<String>(
    value: 'Like',
    title: _buildEmojiTitle(
      'Like',
    ),
    previewIcon: _buildEmojiPreviewIcon(
      AppImageAssets.like,
    ),
    icon: buildReactionsIcon(
      AppImageAssets.like,
      const Text(
        'Like',
        style: TextStyle(
          color: Color(0XFF2196F3),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: 'In love',
    title: _buildEmojiTitle(
      'In love',
    ),
    previewIcon: _buildEmojiPreviewIcon(
      AppImageAssets.love,
    ),
    icon: buildReactionsIcon(
      AppImageAssets.love,
      const Text(
        'In love',
        style: TextStyle(
          color: Color(0XFFffda6b),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: 'Care',
    title: _buildEmojiTitle(
      'Care',
    ),
    previewIcon: _buildEmojiPreviewIcon(
      AppImageAssets.care,
    ),
    icon: buildReactionsIcon(
      AppImageAssets.care,
      const Text(
        'Care',
        style: TextStyle(
          color: Color(0XFFffda6b),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: 'Haha',
    title: _buildEmojiTitle(
      'Haha',
    ),
    previewIcon: _buildEmojiPreviewIcon(
      AppImageAssets.haha,
    ),
    icon: buildReactionsIcon(
      AppImageAssets.haha,
      const Text(
        'Haha',
        style: TextStyle(
          color: Color(0XFF3b5998),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: 'Wow',
    title: _buildEmojiTitle(
      'Wow',
    ),
    previewIcon: _buildEmojiPreviewIcon(
      AppImageAssets.wow,
    ),
    icon: buildReactionsIcon(
      AppImageAssets.wow,
      const Text(
        'Wow',
        style: TextStyle(
          color: Color(0XFF3b5998),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: 'Sad',
    title: _buildEmojiTitle(
      'Sad',
    ),
    previewIcon: _buildEmojiPreviewIcon(
      AppImageAssets.sad,
    ),
    icon: buildReactionsIcon(
      AppImageAssets.sad,
      const Text(
        'Sad',
        style: TextStyle(
          color: Color(0XFFffda6b),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: 'Angry',
    title: _buildEmojiTitle(
      'Angry',
    ),
    previewIcon: _buildEmojiPreviewIcon(
      AppImageAssets.angry,
    ),
    icon: buildReactionsIcon(
      AppImageAssets.angry,
      const Text(
        'Angry',
        style: TextStyle(
          color: Color(0XFFed5168),
        ),
      ),
    ),
  ),
];

int getSelectedIndex(String value) {
  int res = -1;
  for (int i = 0; i < reactions.length; i++) {
    print(
        '---------value------->${reactions[i].value?.toLowerCase() == value.toLowerCase()} $value    ${reactions[i].value}');
    if (reactions[i].value?.toLowerCase() == value.toLowerCase()) {
      res = i;
      return i;
    }
  }
  return res;
}

List<Reaction<String>> getListSelectedReactions(List<LikeType> likes) {
  List<Reaction<String>> list = [];
  for (int i = 0; i < reactions.length; i++) {
    for (int j = 0; j < likes.length; j++) {
      if (reactions[i].value?.toLowerCase() ==
          likes[j].reactionType?.toLowerCase()) {
        list.add(reactions[i]);
      }
    }
  }
  return list;
}

final List<Reaction<String>> reactionscomment = [
  Reaction<String>(
    value: 'Like',
    title: _buildEmojiTitle(
      'Like',
    ),
    previewIcon: _buildEmojiPreviewIcon(
      AppImageAssets.like,
    ),
    icon: buildReactionsIcon(
      AppImageAssets.like,
      const Text(
        'Like',
        style: TextStyle(
          color: Color(0XFF2196F3),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: 'In love',
    title: _buildEmojiTitle(
      'In love',
    ),
    previewIcon: _buildEmojiPreviewIcon(
      AppImageAssets.love,
    ),
    icon: buildReactionsIcon(
      AppImageAssets.love,
      const Text(
        'In love',
        style: TextStyle(
          color: Color(0XFFed5168),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: 'Haha',
    title: _buildEmojiTitle(
      'Haha',
    ),
    previewIcon: _buildEmojiPreviewIcon(
      AppImageAssets.haha,
    ),
    icon: buildReactionsIcon(
      AppImageAssets.haha,
      const Text(
        'Haha',
        style: TextStyle(
          color: Color(0XFF3b5998),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: 'Angry',
    title: _buildEmojiTitle(
      'Angry',
    ),
    previewIcon: _buildEmojiPreviewIcon(
      AppImageAssets.angry,
    ),
    icon: buildReactionsIcon(
      AppImageAssets.angry,
      const Text(
        'Angry',
        style: TextStyle(
          color: Color(0XFFed5168),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: 'Sad',
    title: _buildEmojiTitle(
      'Sad',
    ),
    previewIcon: _buildEmojiPreviewIcon(
      AppImageAssets.sad,
    ),
    icon: buildReactionsIcon(
      AppImageAssets.sad,
      const Text(
        'Sad',
        style: TextStyle(
          color: Color(0XFFffda6b),
        ),
      ),
    ),
  ),
];

Widget _buildEmojiTitle(String title) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(.75),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 8,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildEmojiPreviewIcon(String path) {
  return Image.asset(path);
}

Widget buildReactionsIcon(String path, Text text) {
  return Container(
    color: Colors.transparent,
    child: Row(
      children: <Widget>[
        Image.asset(path, height: 20),
        const SizedBox(width: 5),
        text,
      ],
    ),
  );
}

Widget makeLove() {
  return Container(
    width: 25,
    height: 25,
    decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white)),
    child: const Center(
      child: Icon(Icons.favorite, size: 12, color: Colors.white),
    ),
  );
}

Widget makeLike() {
  return Container(
    width: 25,
    height: 25,
    decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white)),
    child: const Center(
      child: Icon(Icons.thumb_up, size: 12, color: Colors.white),
    ),
  );
}

import 'package:shahin_appify_task/domain/model/feed/feed_response.dart';
import 'package:shahin_appify_task/domain/model/feed/reaction_response.dart';

class ReactionResponseList {
  List<ReactionResponse> reactions;

  ReactionResponseList({required this.reactions});

  factory ReactionResponseList.fromJson(List<dynamic> json) {
    return ReactionResponseList(reactions: json.map((value) => ReactionResponse.fromJson(value)).toList());
  }
}

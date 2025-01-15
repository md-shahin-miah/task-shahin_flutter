import 'package:shahin_appify_task/domain/model/feed/feed_response.dart';

class FeedResponseList {
  List<FeedResponse> feedList;

  FeedResponseList({required this.feedList});

  factory FeedResponseList.fromJson(List<dynamic> json) {
    return FeedResponseList(feedList: json.map((value) => FeedResponse.fromJson(value)).toList());
  }
}

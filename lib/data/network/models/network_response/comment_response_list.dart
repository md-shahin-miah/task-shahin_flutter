import 'package:shahin_appify_task/data/network/models/network_response/comment_response.dart';

class CommentResponseList {
  List<CommentResponse> commentResponseList;

  CommentResponseList({required this.commentResponseList});

  factory CommentResponseList.fromJson(List<dynamic> json) {
    return CommentResponseList(
        commentResponseList:
            json.map((value) => CommentResponse.fromJson(value)).toList());
  }
}

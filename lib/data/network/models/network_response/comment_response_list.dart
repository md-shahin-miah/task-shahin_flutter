import 'package:shahin_appify_task/domain/model/comments/comment_response.dart';

class CommentResponseList {
  List<CommentResponse> commentResponseList;

  CommentResponseList({required this.commentResponseList});

  factory CommentResponseList.fromJson(List<dynamic> json) {
    return CommentResponseList(
        commentResponseList:
            json.map((value) => CommentResponse.fromJson(value)).toList());
  }
}

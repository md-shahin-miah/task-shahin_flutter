import 'package:shahin_appify_task/domain/model/reply/reply_response.dart';

class ReplyResponseList {
  List<ReplyResponse> replyResponseList;

  ReplyResponseList({required this.replyResponseList});

  factory ReplyResponseList.fromJson(List<dynamic> json) {
    return ReplyResponseList(replyResponseList: json.map((value) => ReplyResponse.fromJson(value)).toList());
  }
}

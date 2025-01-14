import 'dart:ffi';

import 'package:equatable/equatable.dart';

class CreateReplyRequest extends Equatable {
  String? feed_id;
  String? feed_user_id="";
  String? comment_txt="";
  String? commentSource="";
  String? parrent_id="";

  CreateReplyRequest({this.feed_id, this.feed_user_id,this.comment_txt,this.commentSource,this.parrent_id});

  @override
  // TODO: implement props
  List<Object?> get props => [ feed_id, feed_user_id,comment_txt,commentSource,parrent_id];


  factory CreateReplyRequest.fromJson(Map<String, dynamic> json) => CreateReplyRequest(
    feed_id: json['feed_id'] as String,
    feed_user_id: json['feed_user_id'] as String,
    comment_txt: json['comment_txt'] as String,
    commentSource: json['commentSource'] as String,
    parrent_id: json['parrent_id'] as String,

  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feed_id'] = feed_id;
    data['feed_user_id'] = feed_user_id;
    data['comment_txt'] = comment_txt;
    data['commentSource'] = commentSource;
    data['parrent_id'] = parrent_id;

    return data;
  }

}

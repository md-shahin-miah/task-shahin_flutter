import 'dart:ffi';

import 'package:equatable/equatable.dart';

class CreateCommentRequest extends Equatable {
  String? feed_id;
  String? feed_user_id="";
  String? comment_txt="";
  String? commentSource="";


  CreateCommentRequest({this.feed_id, this.feed_user_id,this.comment_txt,this.commentSource});

  @override
  // TODO: implement props
  List<Object?> get props => [ feed_id, feed_user_id,comment_txt,commentSource];


  factory CreateCommentRequest.fromJson(Map<String, dynamic> json) => CreateCommentRequest(
    feed_id: json['feed_id'] as String,
    feed_user_id: json['feed_user_id'] as String,
    comment_txt: json['comment_txt'] as String,
    commentSource: json['commentSource'] as String,

  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feed_id'] = feed_id;
    data['feed_user_id'] = feed_user_id;
    data['comment_txt'] = comment_txt;
    data['commentSource'] = commentSource;

    return data;
  }

}

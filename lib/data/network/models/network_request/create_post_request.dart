import 'dart:ffi';

import 'package:equatable/equatable.dart';

class CreatePostRequest extends Equatable {
  String? community_id;
  String? space_id="";
  String? feed_txt="";
  String? uploadType="";
  String? activity_type="";
  int? is_background=0;
  String? bg_color="";

  CreatePostRequest({this.community_id, this.space_id,this.feed_txt,this.uploadType,this.activity_type,this.is_background,this.bg_color});

  @override
  // TODO: implement props
  List<Object?> get props => [ community_id, space_id,feed_txt,uploadType,activity_type,is_background,bg_color];


  factory CreatePostRequest.fromJson(Map<String, dynamic> json) => CreatePostRequest(
    feed_txt: json['feed_txt'] as String,
    community_id: json['community_id'] as String,
    space_id: json['space_id'] as String,
    uploadType: json['uploadType'] as String,
    activity_type: json['activity_type'] as String,
    is_background: json['is_background'] as int,
    bg_color: json['bg_color'] as String,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feed_txt'] = feed_txt;
    data['community_id'] = community_id;
    data['space_id'] = space_id;
    data['uploadType'] = uploadType;
    data['activity_type'] = activity_type;
    data['is_background'] = is_background;
    data['bg_color'] = bg_color;

    return data;
  }

}

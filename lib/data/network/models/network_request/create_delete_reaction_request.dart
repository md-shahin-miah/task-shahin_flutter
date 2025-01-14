import 'dart:ffi';

import 'package:equatable/equatable.dart';

class CreateOrDeleteReactionRequest extends Equatable {
  String? feed_id;
  String? reaction_type="";
  String? action="";
  String? reactionSource="";


  CreateOrDeleteReactionRequest({this.feed_id, this.reaction_type,this.action,this.reactionSource});

  @override
  // TODO: implement props
  List<Object?> get props => [ feed_id, reaction_type,action,reactionSource];


  factory CreateOrDeleteReactionRequest.fromJson(Map<String, dynamic> json) => CreateOrDeleteReactionRequest(
    feed_id: json['feed_id'] as String,
    reaction_type: json['reaction_type'] as String,
    action: json['action'] as String,
    reactionSource: json['reactionSource'] as String,

  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feed_id'] = feed_id;
    data['reaction_type'] = reaction_type;
    data['action'] = action;
    data['reactionSource'] = reactionSource;

    return data;
  }

}

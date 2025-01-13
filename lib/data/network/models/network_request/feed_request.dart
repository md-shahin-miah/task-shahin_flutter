import 'package:equatable/equatable.dart';

class FeedRequest extends Equatable {
  String? community_id;
  String? space_id="";
  String? more="";

  FeedRequest({this.community_id, this.space_id,this.more});

  @override
  // TODO: implement props
  List<Object?> get props => [ community_id, space_id,more];


  factory FeedRequest.fromJson(Map<String, dynamic> json) => FeedRequest(
    more: json['more'] as String,
    community_id: json['community_id'] as String,
    space_id: json['space_id'] as String,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['more'] = more;
    data['community_id'] = community_id;
    data['space_id'] = space_id;

    return data;
  }

}

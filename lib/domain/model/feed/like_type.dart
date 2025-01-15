import 'package:shahin_appify_task/domain/model/common/meta_data.dart';

class LikeType {
  LikeType({
    required this.reactionType,
    required this.feedId,
    required this.meta,
  });

  final String? reactionType;
  final int? feedId;
  final MetaDataClass? meta;

  factory LikeType.fromJson(Map<String, dynamic> json){
    return LikeType(
      reactionType: json["reaction_type"],
      feedId: json["feed_id"],
      meta: json["meta"] == null ? null : MetaDataClass.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "reaction_type": reactionType,
    "feed_id": feedId,
    "meta": meta?.toJson(),
  };

  @override
  String toString(){
    return "$reactionType, $feedId, $meta, ";
  }
}
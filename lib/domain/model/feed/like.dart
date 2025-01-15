import 'package:shahin_appify_task/domain/model/common/meta_data.dart';

class Like {
  Like({
    required this.id,
    required this.feedId,
    required this.userId,
    required this.reactionType,
    required this.createdAt,
    required this.updatedAt,
    required this.isAnonymous,
    required this.meta,
  });

  final int? id;
  final int? feedId;
  final int? userId;
  final String? reactionType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? isAnonymous;
  final MetaDataClass? meta;

  factory Like.fromJson(Map<String, dynamic> json){
    return Like(
      id: json["id"],
      feedId: json["feed_id"],
      userId: json["user_id"],
      reactionType: json["reaction_type"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      isAnonymous: json["is_anonymous"],
      meta: json["meta"] == null ? null : MetaDataClass.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "feed_id": feedId,
    "user_id": userId,
    "reaction_type": reactionType,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "is_anonymous": isAnonymous,
    "meta": meta?.toJson(),
  };

  @override
  String toString(){
    return "$id, $feedId, $userId, $reactionType, $createdAt, $updatedAt, $isAnonymous, $meta, ";
  }
}


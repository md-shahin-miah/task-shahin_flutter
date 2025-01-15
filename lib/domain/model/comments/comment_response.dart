import 'package:shahin_appify_task/domain/model/common/user.dart';

class CommentResponse {
  CommentResponse({
    required this.id,
    required this.schoolId,
    required this.feedId,
    required this.userId,
    required this.replyCount,
    required this.likeCount,
    required this.commentTxt,
    required this.parrentId,
    required this.createdAt,
    required this.updatedAt,
    required this.file,
    required this.privateUserId,
    required this.isAuthorAndAnonymous,
    required this.gift,
    required this.sellerId,
    required this.giftedCoins,
    required this.replies,
    required this.user,
    required this.privateUser,
    required this.totalLikes,
    required this.reactionTypes,
    required this.commentlike,
  });

  final int? id;
  final int? schoolId;
  final int? feedId;
  final int? userId;
  final num? replyCount;
  final num? likeCount;
  final String? commentTxt;
  final dynamic parrentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic file;
  final dynamic privateUserId;
  final num? isAuthorAndAnonymous;
  final dynamic gift;
  final dynamic sellerId;
  final dynamic giftedCoins;
  final List<dynamic> replies;
  final User? user;
  final dynamic privateUser;
  final List<dynamic> totalLikes;
  final List<dynamic> reactionTypes;
  final dynamic commentlike;

  factory CommentResponse.fromJson(Map<String, dynamic> json){
    return CommentResponse(
      id: json["id"],
      schoolId: json["school_id"],
      feedId: json["feed_id"],
      userId: json["user_id"],
      replyCount: json["reply_count"],
      likeCount: json["like_count"],
      commentTxt: json["comment_txt"],
      parrentId: json["parrent_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      file: json["file"],
      privateUserId: json["private_user_id"],
      isAuthorAndAnonymous: json["is_author_and_anonymous"],
      gift: json["gift"],
      sellerId: json["seller_id"],
      giftedCoins: json["gifted_coins"],
      replies: json["replies"] == null ? [] : List<dynamic>.from(json["replies"]!.map((x) => x)),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      privateUser: json["private_user"],
      totalLikes: json["totalLikes"] == null ? [] : List<dynamic>.from(json["totalLikes"]!.map((x) => x)),
      reactionTypes: json["reaction_types"] == null ? [] : List<dynamic>.from(json["reaction_types"]!.map((x) => x)),
      commentlike: json["commentlike"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "school_id": schoolId,
    "feed_id": feedId,
    "user_id": userId,
    "reply_count": replyCount,
    "like_count": likeCount,
    "comment_txt": commentTxt,
    "parrent_id": parrentId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "file": file,
    "private_user_id": privateUserId,
    "is_author_and_anonymous": isAuthorAndAnonymous,
    "gift": gift,
    "seller_id": sellerId,
    "gifted_coins": giftedCoins,
    "replies": replies.map((x) => x).toList(),
    "user": user?.toJson(),
    "private_user": privateUser,
    "totalLikes": totalLikes.map((x) => x).toList(),
    "reaction_types": reactionTypes.map((x) => x).toList(),
    "commentlike": commentlike,
  };

  @override
  String toString(){
    return "$id, $schoolId, $feedId, $userId, $replyCount, $likeCount, $commentTxt, $parrentId, $createdAt, $updatedAt, $file, $privateUserId, $isAuthorAndAnonymous, $gift, $sellerId, $giftedCoins, $replies, $user, $privateUser, $totalLikes, $reactionTypes, $commentlike, ";
  }
}



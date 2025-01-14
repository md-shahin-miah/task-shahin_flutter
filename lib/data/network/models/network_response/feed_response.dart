import 'package:shahin_appify_task/domain/model/meta_data.dart';
import 'package:shahin_appify_task/domain/model/user.dart';

class FeedResponseList{

  List<FeedResponse> feedList;
  FeedResponseList({required this.feedList});

  factory FeedResponseList.fromJson(List<dynamic> json){
    return FeedResponseList(feedList: json.map((value) => FeedResponse.fromJson(value)).toList());

  }


  }


class PurpleMeta {
  PurpleMeta({
    required this.views,
  });

  final num? views;

  factory PurpleMeta.fromJson(Map<String, dynamic> json){
    return PurpleMeta(
      views: json["views"],
    );
  }

  Map<String, dynamic> toJson() => {
    "views": views,
  };

  @override
  String toString(){
    return "$views, ";
  }
}


class FeedResponse {
  FeedResponse({
    required this.id,
    required this.schoolId,
    required this.userId,
    required this.courseId,
    required this.communityId,
    required this.groupId,
    required this.feedTxt,
    required this.status,
    required this.slug,
    required this.title,
    required this.activityType,
    required this.isPinned,
    required this.fileType,
    required this.files,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.shareId,
    required this.metaData,
    required this.createdAt,
    required this.updatedAt,
    required this.feedPrivacy,
    required this.isBackground,
    required this.bgColor,
    required this.pollId,
    required this.lessonId,
    required this.spaceId,
    required this.videoId,
    required this.streamId,
    required this.blogId,
    required this.scheduleDate,
    required this.timezone,
    required this.isAnonymous,
    required this.meetingId,
    required this.sellerId,
    required this.publishDate,
    required this.isFeedEdit,
    required this.name,
    required this.pic,
    required this.uid,
    required this.isPrivateChat,
    required this.likeType,
    required this.poll,
    required this.like,
    required this.group,
    required this.user,
    required this.savedPosts,
    required this.follow,
    required this.comments,
    required this.meta,
  });

  final int? id;
  final int? schoolId;
  final int? userId;
  final dynamic courseId;
  final int? communityId;
  final dynamic groupId;
  final String? feedTxt;
  final String? status;
  final String? slug;
  final String? title;
  final String? activityType;
  final num? isPinned;
  final String? fileType;
  final List<dynamic> files;
  final num? likeCount;
  final num? commentCount;
  final num? shareCount;
  final int? shareId;
  final MetaDataClass? metaData;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? feedPrivacy;
  final num? isBackground;
  final String? bgColor;
  final dynamic pollId;
  final dynamic lessonId;
  final int? spaceId;
  final dynamic videoId;
  final dynamic streamId;
  final dynamic blogId;
  final dynamic scheduleDate;
  final dynamic timezone;
  final dynamic isAnonymous;
  final dynamic meetingId;
  final dynamic sellerId;
  final DateTime? publishDate;
  final bool? isFeedEdit;
  final String? name;
  final String? pic;
  final int? uid;
  final num? isPrivateChat;
  final List<LikeType> likeType;
  final dynamic poll;
  final Like? like;
  final dynamic group;
  final User? user;
  final dynamic savedPosts;
  final dynamic follow;
  final List<dynamic> comments;
  final PurpleMeta? meta;

  factory FeedResponse.fromJson(Map<String, dynamic> json){
    return FeedResponse(
      id: json["id"],
      schoolId: json["school_id"],
      userId: json["user_id"],
      courseId: json["course_id"],
      communityId: json["community_id"],
      groupId: json["group_id"],
      feedTxt: json["feed_txt"],
      status: json["status"],
      slug: json["slug"],
      title: json["title"],
      activityType: json["activity_type"],
      isPinned: json["is_pinned"],
      fileType: json["file_type"],
      files: json["files"] == null ? [] : List<dynamic>.from(json["files"]!.map((x) => x)),
      likeCount: json["like_count"],
      commentCount: json["comment_count"],
      shareCount: json["share_count"],
      shareId: json["share_id"],
      metaData: json["meta_data"] == null ? null : MetaDataClass.fromJson(json["meta_data"]),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      feedPrivacy: json["feed_privacy"],
      isBackground: json["is_background"],
      bgColor: json["bg_color"],
      pollId: json["poll_id"],
      lessonId: json["lesson_id"],
      spaceId: json["space_id"],
      videoId: json["video_id"],
      streamId: json["stream_id"],
      blogId: json["blog_id"],
      scheduleDate: json["schedule_date"],
      timezone: json["timezone"],
      isAnonymous: json["is_anonymous"],
      meetingId: json["meeting_id"],
      sellerId: json["seller_id"],
      publishDate: DateTime.tryParse(json["publish_date"] ?? ""),
      isFeedEdit: json["is_feed_edit"],
      name: json["name"],
      pic: json["pic"],
      uid: json["uid"],
      isPrivateChat: json["is_private_chat"],
      likeType: json["likeType"] == null ? [] : List<LikeType>.from(json["likeType"]!.map((x) => LikeType.fromJson(x))),
      poll: json["poll"],
      like: json["like"] == null ? null : Like.fromJson(json["like"]),
      group: json["group"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      savedPosts: json["savedPosts"],
      follow: json["follow"],
      comments: json["comments"] == null ? [] : List<dynamic>.from(json["comments"]!.map((x) => x)),
      meta: json["meta"] == null ? null : PurpleMeta.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "school_id": schoolId,
    "user_id": userId,
    "course_id": courseId,
    "community_id": communityId,
    "group_id": groupId,
    "feed_txt": feedTxt,
    "status": status,
    "slug": slug,
    "title": title,
    "activity_type": activityType,
    "is_pinned": isPinned,
    "file_type": fileType,
    "files": files.map((x) => x).toList(),
    "like_count": likeCount,
    "comment_count": commentCount,
    "share_count": shareCount,
    "share_id": shareId,
    "meta_data": metaData?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "feed_privacy": feedPrivacy,
    "is_background": isBackground,
    "bg_color": bgColor,
    "poll_id": pollId,
    "lesson_id": lessonId,
    "space_id": spaceId,
    "video_id": videoId,
    "stream_id": streamId,
    "blog_id": blogId,
    "schedule_date": scheduleDate,
    "timezone": timezone,
    "is_anonymous": isAnonymous,
    "meeting_id": meetingId,
    "seller_id": sellerId,
    "publish_date": publishDate?.toIso8601String(),
    "is_feed_edit": isFeedEdit,
    "name": name,
    "pic": pic,
    "uid": uid,
    "is_private_chat": isPrivateChat,
    "likeType": likeType.map((x) => x?.toJson()).toList(),
    "poll": poll,
    "like": like?.toJson(),
    "group": group,
    "user": user?.toJson(),
    "savedPosts": savedPosts,
    "follow": follow,
    "comments": comments.map((x) => x).toList(),
    "meta": meta?.toJson(),
  };

  @override
  String toString(){
    return "$id, $schoolId, $userId, $courseId, $communityId, $groupId, $feedTxt, $status, $slug, $title, $activityType, $isPinned, $fileType, $files, $likeCount, $commentCount, $shareCount, $shareId, $metaData, $createdAt, $updatedAt, $feedPrivacy, $isBackground, $bgColor, $pollId, $lessonId, $spaceId, $videoId, $streamId, $blogId, $scheduleDate, $timezone, $isAnonymous, $meetingId, $sellerId, $publishDate, $isFeedEdit, $name, $pic, $uid, $isPrivateChat, $likeType, $poll, $like, $group, $user, $savedPosts, $follow, $comments, $meta, ";
  }
}

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

class MetaDataClass {
  MetaDataClass({required this.json});
  final Map<String,dynamic> json;

  factory MetaDataClass.fromJson(Map<String, dynamic> json){
    return MetaDataClass(
        json: json
    );
  }

  Map<String, dynamic> toJson() => {
  };

  @override
  String toString(){
    return "";
  }
}

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


class User {
  User({
    required this.id,
    required this.fullName,
    required this.profilePic,
    required this.isPrivateChat,
    required this.expireDate,
    required this.status,
    required this.pauseDate,
    required this.userType,
    required this.meta,
  });

  final int? id;
  final String? fullName;
  final String? profilePic;
  final num? isPrivateChat;
  final dynamic expireDate;
  final String? status;
  final dynamic pauseDate;
  final String? userType;
  final MetaDataClass? meta;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"],
      fullName: json["full_name"],
      profilePic: json["profile_pic"],
      isPrivateChat: json["is_private_chat"],
      expireDate: json["expire_date"],
      status: json["status"],
      pauseDate: json["pause_date"],
      userType: json["user_type"],
      meta: json["meta"] == null ? null : MetaDataClass.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "profile_pic": profilePic,
    "is_private_chat": isPrivateChat,
    "expire_date": expireDate,
    "status": status,
    "pause_date": pauseDate,
    "user_type": userType,
    "meta": meta?.toJson(),
  };

  @override
  String toString(){
    return "$id, $fullName, $profilePic, $isPrivateChat, $expireDate, $status, $pauseDate, $userType, $meta, ";
  }
}



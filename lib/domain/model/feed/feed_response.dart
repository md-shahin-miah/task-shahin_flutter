import 'package:flutter/cupertino.dart';
import 'package:shahin_appify_task/domain/model/feed/like.dart';
import 'package:shahin_appify_task/domain/model/feed/like_type.dart';
import 'package:shahin_appify_task/domain/model/common/meta_data.dart';
import 'package:shahin_appify_task/domain/model/common/user.dart';

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
  late final num? likeCount;
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
  late  Like? like;
  final dynamic group;
  final User? user;
  final dynamic savedPosts;
  final dynamic follow;
  final List<dynamic> comments;
  final MetaDataClass? meta;

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
      meta: json["meta"] == null ? null : MetaDataClass.fromJson(json["meta"]),
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
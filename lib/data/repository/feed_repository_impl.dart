import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:shahin_appify_task/core/constants/end_points.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_comment_request.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_delete_reaction_request.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_post_request.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_reply_request.dart';
import '../../domain/repository/feed_repository.dart';
import '../network/models/network_request/feed_request.dart';
import '../network/network_service.dart';

final feedRepoProvider = Provider((ref) => FeedRepositoryImpl());

class FeedRepositoryImpl extends FeedRepository {
  @override
  Future<Response> getFeed(FeedRequest feedRequest) async {
    return await NetworkService.postRequest(EndPoints.feedUrl, feedRequest,
        requireToken: true);
  }

  @override
  Future createPost(CreatePostRequest createPostReq) async {
    return await NetworkService.postRequest(
        EndPoints.createFeedPostUrl, createPostReq,
        requireToken: true);
  }

  @override
  Future createComment(CreateCommentRequest createCommentRequest) async {
    return await NetworkService.postRequest(
        EndPoints.createCommentUrl, createCommentRequest,
        requireToken: true);
  }

  @override
  Future getComment(String feedId) async {
    return await NetworkService.getRequest(EndPoints.getCommentUrl + feedId,
        requireToken: true);
  }

  @override
  Future getReactions(String feedId) async {
    return await NetworkService.getRequest("${EndPoints.getReactions}feed_id=$feedId",
        requireToken: true);
  }

  @override
  Future createOrDeletedReaction(
      CreateOrDeleteReactionRequest createOrDeleteReactionRequest) async {
    return await NetworkService.postRequest(
        EndPoints.createOrDeleteReactionUrl, createOrDeleteReactionRequest,
        requireToken: true);
  }

  @override
  Future createReply(CreateReplyRequest createReplyRequest) async {
    return await NetworkService.postRequest(
        EndPoints.adReply, createReplyRequest,
        requireToken: true);
  }

  @override
  Future getReply(String commentID) async {
    return await NetworkService.getRequest(EndPoints.getReply + commentID,
        requireToken: true);
  }
}

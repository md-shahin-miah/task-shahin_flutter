import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:shahin_appify_task/core/constants/end_points.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_comment_request.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_post_request.dart';
import '../../domain/repository/feed_repository.dart';
import '../network/models/network_request/feed_request.dart';
import '../network/network_service.dart';

final feedRepoProvider = Provider((ref) => FeedRepositoryImpl());

class FeedRepositoryImpl extends FeedRepository {
  @override
  Future<Response> getFeed(FeedRequest feedRequest) async {
    return await NetworkService.postRequest(EndPoints.feedUrl, feedRequest, requireToken: true);
  }

  @override
  Future createPost(CreatePostRequest createPostReq) async {
    // TODO: implement createPost
    return await NetworkService.postRequest(EndPoints.createFeedPostUrl, createPostReq, requireToken: true);
  }

  @override
  Future createComment(CreateCommentRequest createCommentRequest) async {
    return await NetworkService.postRequest(EndPoints.createFeedPostUrl, createCommentRequest, requireToken: true);

  }

  @override
  Future getComment(CreatePostRequest createPostReq) {
    // TODO: implement getComment
    throw UnimplementedError();
  }
}



import 'package:shahin_appify_task/data/network/models/network_request/create_comment_request.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_post_request.dart';
import 'package:shahin_appify_task/data/network/models/network_request/feed_request.dart';

abstract class FeedRepository {
  Future getFeed(FeedRequest feedRequest);
  Future createPost(CreatePostRequest createPostReq);
  Future createComment(CreateCommentRequest createCommentRequest);
  Future getComment(CreatePostRequest createPostReq);
}

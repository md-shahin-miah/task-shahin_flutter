

import 'package:shahin_appify_task/data/network/models/network_request/create_comment_request.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_delete_reaction_request.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_post_request.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_reply_request.dart';
import 'package:shahin_appify_task/data/network/models/network_request/feed_request.dart';

abstract class FeedRepository {
  Future getFeed(FeedRequest feedRequest);
  Future createPost(CreatePostRequest createPostReq);
  Future createComment(CreateCommentRequest createCommentRequest);
  Future getComment(String feedId);
  Future createOrDeletedReaction(CreateOrDeleteReactionRequest createOrDeleteReactionRequest);
  Future getReply(String commentID);
  Future createReply(CreateReplyRequest createReplyRequest);
  Future getReactions(String feedId);
}

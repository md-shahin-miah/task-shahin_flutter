import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_comment_request.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_delete_reaction_request.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_post_request.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_reply_request.dart';
import 'package:shahin_appify_task/data/network/models/network_request/feed_request.dart';
import 'package:shahin_appify_task/data/network/models/network_response/feed_response.dart';
import 'package:shahin_appify_task/data/network/models/network_response/reply_response.dart';
import 'package:shahin_appify_task/data/repository/feed_repository_impl.dart';
import 'package:shahin_appify_task/data/state/data_state.dart';

import '../../../../data/network/models/network_response/comment_response_list.dart';

final feedFutureProvider = FutureProvider.family<FeedResponseList?, FeedRequest>((ref, FeedRequest locationQueryModel) => ref.read(feedProvider).getFeedData(locationQueryModel));
final commentFutureProvider = FutureProvider.family<CommentResponseList?, String>((ref, String feedId) => ref.read(feedProvider).getComment(feedId));
final replyFutureProvider = FutureProvider.family<ReplyResponseList?, String>((ref, String feedId) => ref.read(feedProvider).getReply(feedId));

final feedProvider = Provider<FeedScreenViewModel>((ref) => FeedScreenViewModel(ref));
final createFeedStateNotifierProvider = StateNotifierProvider.autoDispose<FeedScreenViewModel, DataState>((ref) => FeedScreenViewModel(ref));
final createCommentStateNotifierProvider = StateNotifierProvider.autoDispose<FeedScreenViewModel, DataState>((ref) => FeedScreenViewModel(ref));
final createReplyStateNotifierProvider = StateNotifierProvider.autoDispose<FeedScreenViewModel, DataState>((ref) => FeedScreenViewModel(ref));
final createOrDeleteReactionStateNotifierProvider = StateNotifierProvider.autoDispose<FeedScreenViewModel, DataState>((ref) => FeedScreenViewModel(ref));

class FeedScreenViewModel extends StateNotifier<DataState> {
  Ref ref;

  FeedScreenViewModel(this.ref) : super(const DataState.initial());
  final connectivity = Connectivity();

  Future<FeedResponseList?> getFeedData(FeedRequest feedRequest) async {
    final result = await connectivity.checkConnectivity();

    FeedResponseList? feedResponseList;
    try {
      if (result == ConnectivityResult.none) {
      } else {
        var response = await ref.read(feedRepoProvider).getFeed(feedRequest);

        if (response.statusCode == 200) {
          feedResponseList = FeedResponseList.fromJson(json.decode(response.body));
        } else {
          throw Exception("Failed, please try again.");
        }
      }
    } on SocketException catch (e) {
      throw Exception('Failed to load landing data: ${e.message}');
    }
    return feedResponseList;
  }

  Future<ReplyResponseList?> getReply(String commentID) async {
    final result = await connectivity.checkConnectivity();

    ReplyResponseList? replyResponseList;
    try {
      if (result == ConnectivityResult.none) {
      } else {
        var response = await ref.read(feedRepoProvider).getReply(commentID);

        // print('--------getReply---->' + json.decode(response.body));

        if (response.statusCode == 200) {
          if (response.body != null) {
            replyResponseList = ReplyResponseList.fromJson(json.decode(response.body));
          }
        } else {
          throw Exception("Failed, please try again.");
        }
      }
    } on SocketException catch (e) {
      throw Exception('Failed to load landing data: ${e.message}');
    }
    return replyResponseList;
  }

  Future<CommentResponseList?> getComment(String feedId) async {
    final result = await connectivity.checkConnectivity();

    CommentResponseList? commentResponseList;
    try {
      if (result == ConnectivityResult.none) {
      } else {
        var response = await ref.read(feedRepoProvider).getComment(feedId);

        if (response.statusCode == 200) {
          commentResponseList = CommentResponseList.fromJson(json.decode(response.body));
        } else {
          throw Exception("Failed, please try again.");
        }
      }
    } on SocketException catch (e) {
      throw Exception('Failed to load landing data: ${e.message}');
    }
    return commentResponseList;
  }

  Future<void> createPost(CreatePostRequest createPostRequest) async {
    state = const DataState.loading();
    final result = await connectivity.checkConnectivity();

    // FeedResponse? feedResponse;
    try {
      if (result == ConnectivityResult.none) {
      } else {
        var response = await ref.read(feedRepoProvider).createPost(createPostRequest);

        if (response.statusCode == 200) {
          var feedResponse = FeedResponse.fromJson(json.decode(response.body));

          state = DataState.success(data: feedResponse);
        } else {
          state = const DataState.error(message: "Failed to create");
        }
      }
    } on SocketException catch (e) {
      state = DataState.error(message: 'Failed to load landing data: ${e.message}');

      throw Exception('Failed to load landing data: ${e.message}');
    }
  }

  Future<void> createReply(CreateReplyRequest createReplyRequest) async {
    state = const DataState.loading();
    final result = await connectivity.checkConnectivity();

    try {
      if (result == ConnectivityResult.none) {
        //local db
      } else {
        var response = await ref.read(feedRepoProvider).createReply(createReplyRequest);

        if (response.statusCode == 200) {
          state = DataState.success(data: response);
        } else {
          state = const DataState.error(message: "Failed to create");
        }
      }
    } on SocketException catch (e) {
      state = DataState.error(message: 'Failed to load landing data: ${e.message}');

      throw Exception('Failed to load landing data: ${e.message}');
    }
  }

  Future<void> logout(CreatePostRequest createPostRequest) async {
    state = const DataState.loading();
    final result = await connectivity.checkConnectivity();

    try {
      if (result == ConnectivityResult.none) {
      } else {
        var response = await ref.read(feedRepoProvider).createPost(createPostRequest);

        if (response.statusCode == 200) {
          var feedResponse = FeedResponse.fromJson(json.decode(response.body));

          state = DataState.success(data: feedResponse);
        } else {
          state = const DataState.error(message: "Failed to create");
        }
      }
    } on SocketException catch (e) {
      state = DataState.error(message: 'Failed to load landing data: ${e.message}');

      throw Exception('Failed to load landing data: ${e.message}');
    }
  }

  Future<void> createOrDeleteReaction(CreateOrDeleteReactionRequest createOrDeleteReactionRequest) async {
    state = const DataState.loading();
    final result = await connectivity.checkConnectivity();

    // FeedResponse? feedResponse;
    try {
      if (result == ConnectivityResult.none) {
      } else {
        var response = await ref.read(feedRepoProvider).createOrDeletedReaction(createOrDeleteReactionRequest);

        if (response.statusCode == 200) {
          state = DataState.success(data: response);
        } else {
          state = const DataState.error(message: "Failed to create");
        }
      }
    } on SocketException catch (e) {
      state = DataState.error(message: 'Failed to load landing data: ${e.message}');

      throw Exception('Failed to load landing data: ${e.message}');
    }
  }

  Future<void> createComment(CreateCommentRequest createCommentRequest) async {
    state = const DataState.loading();
    final result = await connectivity.checkConnectivity();

    try {
      if (result == ConnectivityResult.none) {
      } else {
        var response = await ref.read(feedRepoProvider).createComment(createCommentRequest);

        if (response.statusCode == 200) {
          var feedResponse = FeedResponse.fromJson(json.decode(response.body));

          state = DataState.success(data: feedResponse);
        } else {
          state = const DataState.error(message: "Failed to create");
        }
      }
    } on SocketException catch (e) {
      state = DataState.error(message: 'Failed to load landing data: ${e.message}');

      throw Exception('Failed to load landing data: ${e.message}');
    }
  }
}

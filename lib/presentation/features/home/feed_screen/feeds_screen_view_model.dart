import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_comment_request.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_post_request.dart';
import 'package:shahin_appify_task/data/network/models/network_request/feed_request.dart';
import 'package:shahin_appify_task/data/network/models/network_response/feed_response.dart';
import 'package:shahin_appify_task/data/repository/feed_repository_impl.dart';
import 'package:shahin_appify_task/data/state/data_state.dart';

final feedFutureProvider = FutureProvider.family<FeedResponseList?, FeedRequest>((ref, FeedRequest locationQueryModel) => ref.read(feedProvider).getFeedData(locationQueryModel));

final feedProvider = Provider<FeedScreenViewModel>((ref) => FeedScreenViewModel(ref));
final createFeedStateNotifierProvider = StateNotifierProvider.autoDispose<FeedScreenViewModel, DataState>((ref) => ref.read(feedProvider));

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

        print("----------getFeedData res------->${json.decode(response.body)}");

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

  Future<void> createPost(CreatePostRequest createPostRequest) async {
    state = const DataState.loading();
    final result = await connectivity.checkConnectivity();

    // FeedResponse? feedResponse;
    try {
      if (result == ConnectivityResult.none) {
      } else {
        var response = await ref.read(feedRepoProvider).createPost(createPostRequest);

        print("----------createPost res------->${json.decode(response.body)}");

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

  Future<void> createComment(CreateCommentRequest createCommentRequest) async {
    state = const DataState.loading();
    final result = await connectivity.checkConnectivity();

    // FeedResponse? feedResponse;
    try {
      if (result == ConnectivityResult.none) {
      } else {
        var response = await ref.read(feedRepoProvider).createComment(createCommentRequest);

        print("----------createPost res------->${json.decode(response.body)}");

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

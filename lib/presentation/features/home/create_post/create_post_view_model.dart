import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shahin_appify_task/data/network/models/network_request/create_post_request.dart';
import 'package:shahin_appify_task/data/repository/feed_repository_impl.dart';
import 'package:shahin_appify_task/data/state/data_state.dart';
import 'package:shahin_appify_task/domain/model/feed/feed_response.dart';



final createFeedStateNotifierProvider = StateNotifierProvider.autoDispose<CreatePostViewModel, DataState>((ref) => CreatePostViewModel(ref));

class CreatePostViewModel extends StateNotifier<DataState> {
  Ref ref;

  CreatePostViewModel(this.ref) : super(const DataState.initial());
  final connectivity = Connectivity();


  Future<void> createPost(CreatePostRequest createPostRequest) async {
    state = const DataState.loading();
    final result = await connectivity.checkConnectivity();

    // FeedResponse? feedResponse;
    try {
      if (result == ConnectivityResult.none) {
        state = const DataState.error(message: "No internet connection, please try again.");
        throw Exception("No internet connection, please try again.");

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


}

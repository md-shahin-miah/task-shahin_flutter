import 'dart:async';

import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shahin_appify_task/data/network/models/network_request/login_request.dart';
import 'package:shahin_appify_task/data/network/models/network_response/login_response.dart';
import 'package:shahin_appify_task/data/repository/auth_repository_impl.dart';
import 'package:shahin_appify_task/data/share_preference/shared_preference_service.dart';
import 'package:shahin_appify_task/data/state/data_state.dart';

final authProviderLogin = StateNotifierProvider.autoDispose<AuthViewModel, DataState>((ref) => AuthViewModel(ref));

final authProv = Provider.autoDispose((ref) => AuthViewModel(ref));

class AuthViewModel extends StateNotifier<DataState> {
  Ref ref;

  AuthViewModel(this.ref) : super(const DataState.initial());
  final connectivity = Connectivity();

  Future<void> login(String email, String pass) async {
    state = const DataState.loading();
    try {
      final result = await connectivity.checkConnectivity();

      if (result != ConnectivityResult.none) {
        var response = await ref.read(authRepoProvider).login(LoginRequest(email: email, password: pass, appToken: " "));

        print("----------login res------->${response.body}");
        var loginResponse = LoginResponse.fromJson(json.decode(response.body));

        if (response.statusCode == 200) {
          if (loginResponse.type == "bearer") {
            SharePreferenceUtil.setUserToken(loginResponse.token ?? "");
            state = DataState.success(data: loginResponse);
          } else {
            state = const DataState.error(message: "You are not supported here. Only User can login.");
          }
        } else {
          state = DataState.error(message: loginResponse.msg ?? "Login failed, please try again.");
        }
      } else {
        state = const DataState.error(message: "No internet Connection");
      }
    } catch (e) {
      state = DataState.error(message: e.toString());
    }
  }
  Future<void> logOut() async {
    state = const DataState.loading();
    try {
      final result = await connectivity.checkConnectivity();

      if (result != ConnectivityResult.none) {
        var response = await ref.read(authRepoProvider).logout();

        print("----------login res------->${response.body}");

        if (response.statusCode == 200) {
          SharePreferenceUtil.setUserToken("");
          SharePreferenceUtil.setRememberMe(false);
            state = DataState.success(data: response);

        } else {
          state = const DataState.error(message: "Logout, please try again.");
        }
      } else {
        state = const DataState.error(message: "No internet Connection");
      }
    } catch (e) {
      state = DataState.error(message: e.toString());
    }
  }
}

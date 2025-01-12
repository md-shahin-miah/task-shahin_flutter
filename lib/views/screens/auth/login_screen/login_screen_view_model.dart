import 'dart:async';

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shahin_appify_task/models/network_request/login_request.dart';

import '../../../../core/repository/auth_repository.dart';
import '../../../../models/network_response/login_response.dart';
import '../../../../models/state/data_state.dart';


final passwordObscureTextSignUp = StateProvider((ref) {
  return true;
});
final passwordObscureText = StateProvider((ref) {
  return true;
});

final termsAndCondition=StateProvider((ref) => false);

final authProviderLogin =
StateNotifierProvider.autoDispose<AuthViewModel, DataState>((ref) => AuthViewModel(ref));

final authProv =
Provider.autoDispose((ref) => AuthViewModel(ref));


class AuthViewModel extends StateNotifier<DataState> {

  Ref ref;
  AuthViewModel(this.ref) : super(const DataState.initial());

  Future<void> login(String email, String pass) async {
    state = const DataState.loading();
    try {


      var response = await ref
          .read(authRepoProvider)
          .login(LoginRequest(email: email, password: pass,appToken: " "));

      print("----------login res------->${json.decode(response.body)}");
      var loginResponse = LoginResponse.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {


        if (loginResponse.type == "bearer") {
          state = DataState.success(data: loginResponse);
        } else {
          state = const DataState.error(message: "You are not supported here. Only User can login.");
        }
      } else {
        state = DataState.error(message: loginResponse.msg ?? "Login failed, please try again.");
      }
    } catch (e) {
      state = DataState.error(message: e.toString());
    }
  }



}

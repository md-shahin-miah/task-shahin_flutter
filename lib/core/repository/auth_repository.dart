import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:shahin_appify_task/core/constants/end_points.dart';
import 'package:shahin_appify_task/models/network_request/login_request.dart';
import 'package:shahin_appify_task/models/network_response/login_response.dart';

import '../../services/remote_network/network_service.dart';
final authRepoProvider = Provider((ref) => AuthRepositoryImpl());

abstract class AuthRepository {
  Future login(LoginRequest loginRequest);
}

 class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<Response> login(LoginRequest loginRequest) async {

    return await NetworkService.postRequest(EndPoints.loginUrl, loginRequest);
  }


 }

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:shahin_appify_task/core/constants/end_points.dart';
import 'package:shahin_appify_task/data/network/models/network_request/login_request.dart';
import 'package:shahin_appify_task/data/network/network_service.dart';
import 'package:shahin_appify_task/domain/repository/auth_repository.dart';


final authRepoProvider = Provider((ref) => AuthRepositoryImpl());


 class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<Response> login(LoginRequest loginRequest) async {

    return await NetworkService.postRequest(EndPoints.loginUrl, loginRequest);
  }

  @override
  Future logout() async {
   return await NetworkService.postRequest(EndPoints.logoutUrl,[],requireToken: true);

  }


 }

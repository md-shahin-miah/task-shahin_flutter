import '../../data/network/models/network_request/login_request.dart';

abstract class AuthRepository {
  Future login(LoginRequest loginRequest);
}

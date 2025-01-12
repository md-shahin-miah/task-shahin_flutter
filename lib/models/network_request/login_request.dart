import 'package:equatable/equatable.dart';

class LoginRequest extends Equatable {
  String? email;

  String? password;
  String? appToken="";

  LoginRequest({this.email, this.password, this.appToken});

  @override
  // TODO: implement props
  List<Object?> get props => [email, password, appToken];

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        email: json['email'] as String,
        password: json['password'] as String,
        appToken: json['app_token'] as String,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['app_token'] = appToken;

    return data;
  }
}

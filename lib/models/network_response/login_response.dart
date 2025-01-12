class LoginResponse {
  String? type;
  String? token;
  String? msg;

  LoginResponse({this.type, this.token, this.msg});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    token = json['token'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    data['token'] = token;
    data['msg'] = msg;
    return data;
  }
}

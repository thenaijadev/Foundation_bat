class LoginRequestModel {

  LoginRequestModel({
    required this.identity,
    required this.password,
  });
  late final String identity;
  late final String password;

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    identity = json['identity'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['identity'] = identity;
    _data['password'] = password;
    return _data;
  }
}

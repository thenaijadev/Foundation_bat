class RegisterRequestModel {

  RegisterRequestModel.dart({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.passwordConfirm,
    required this.location,
    required this.dob,
  });
  
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String password;
  late final String passwordConfirm;
  late final String location;
  late final String dob;
  
  RegisterRequestModel.fromJson(Map<String, dynamic> json){
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    passwordConfirm = json['password_confirm'];
    location = json['location'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['password'] = password;
    _data['password_confirm'] = passwordConfirm;
    _data['location'] = location;
    _data['dob'] = dob;
    return _data;
  }
}
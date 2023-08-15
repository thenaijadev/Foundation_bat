part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthEventLogin extends AuthEvent {
  const AuthEventLogin({required this.email, required this.password});
  final String email;
  final String password;
}

class AuthEventResetPassword extends AuthEvent {
  const AuthEventResetPassword({required this.email});
  final String email;
}

class AuthEventRegister extends AuthEvent {
  const AuthEventRegister({
    required this.firstName,
    required this.lastName,
    required this.location,
    required this.birthDate,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  final String email;
  final String password;
  final String confirmPassword;
  final String birthDate;
  final String location;
  final String lastName;
  final String firstName;
}

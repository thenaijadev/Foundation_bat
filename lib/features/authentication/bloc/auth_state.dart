part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthStateIsLoading extends AuthState {}

class AuthStateError extends AuthState {
  const AuthStateError({required this.errorMessage});
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

class AuthStateLoginSuccess extends AuthState {}

class AuthStateRegistrationSuccess extends AuthState {
  const AuthStateRegistrationSuccess({required this.message});
  final String message;
}

class AuthStateResetPasswordSuccess extends AuthState {
  const AuthStateResetPasswordSuccess({required this.message});
  final String message;
}

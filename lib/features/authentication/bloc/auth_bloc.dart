// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';
import 'package:batnf/features/authentication/data/repository/auth_repository.dart';
import 'package:batnf/utilities/local_session_manager/local_session_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LocalSessionManager localSessionManager = LocalSessionManager();
  AuthBloc(AuthRepository repo) : super(AuthInitial()) {
    on<AuthEventLogin>((event, emit) async {
      emit(AuthStateIsLoading());
      final String email = event.email;
      final String password = event.password;
      final response = await repo.login(email: email, password: password);
      response.fold((l) => emit(AuthStateError(errorMessage: l)), (r) {
        localSessionManager.authStatusVal = true;
        localSessionManager.authUserIdVal = r["userId"];
        localSessionManager.authUserEmail = event.email;
        return emit(AuthStateLoginSuccess());
      });
    });

    on<AuthEventResetPassword>((event, emit) async {
      emit(AuthStateIsLoading());
      final String email = event.email;
      final response = await repo.resetPassword(email: email);
      response.fold((l) => emit(AuthStateError(errorMessage: l)), (r) {
        return emit(AuthStateResetPasswordSuccess(message: r["message"]));
      });
    });

    on<AuthEventRegister>((event, emit) async {
      emit(AuthStateIsLoading());
      final String email = event.email;
      final String password = event.password;
      final String date = event.birthDate;
      final String confirmPassword = event.confirmPassword;
      final String location = event.location;
      final String firstName = event.firstName;
      final String lastName = event.lastName;

      final response = await repo.register(
          email: email,
          password: password,
          lastname: lastName,
          firstname: firstName,
          location: location,
          passwordconfirm: confirmPassword,
          date: date);
      response.fold((l) => emit(AuthStateError(errorMessage: l)), (r) {
        return emit(AuthStateRegistrationSuccess(message: r["message"]));
      });
    });
  }
}

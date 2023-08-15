import 'package:batnf/features/authentication/data/providers/auth_provider.dart';
import 'package:batnf/utilities/typedefs.dart';

class AuthRepository {
  final AuthProvider provider = AuthProvider();

  EitherMap register(
      {required String firstname,
      required String lastname,
      required String email,
      required String password,
      required String passwordconfirm,
      required String location,
      required String date}) async {
    final response = await provider.register(
        firstname: firstname,
        lastname: lastname,
        email: email,
        password: password,
        passwordconfirm: passwordconfirm,
        location: location,
        date: date);
    return response;
  }

  EitherMap login({
    required String email,
    required String password,
  }) async {
    final response = await provider.login(email: email, password: password);
    return response;
  }

  EitherMap resetPassword({
    required String email,
  }) async {
    final response = await provider.resetPassword(email: email);
    return response;
  }
}

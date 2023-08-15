import 'package:batnf/utilities/typedefs.dart';

abstract class AuthInterface {
  EitherMap register(
      {required String firstname,
      required String lastname,
      required String email,
      required String password,
      required String passwordconfirm,
      required String location,
      required String date});

  EitherMap login({
    required String email,
    required String password,
  });

  EitherMap resetPassword({
    required String email,
  });
}

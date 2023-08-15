import 'package:batnf/features/home/data/projects/model/response/response_data_model.dart';
import 'package:dartz/dartz.dart';

abstract class ChangePasswordRepository {
  Future<Either<String,SuccessResponseModel>> changePassword({required String identity, required String oldPassword, required String newPassword});
}

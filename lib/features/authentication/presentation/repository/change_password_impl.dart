import 'dart:convert';
import 'package:batnf/dio/dio_core/dio_client.dart';
import 'package:batnf/features/authentication/presentation/repository/change_password.dart';
import 'package:batnf/features/home/data/projects/model/response/response_data_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ChangePasswordImpl extends ChangePasswordRepository{
  final NetworkProvider _networkProvider = NetworkProvider();

  @override
  Future<Either<String, SuccessResponseModel>> changePassword({required String identity, required String oldPassword, required String newPassword}) async {
    try {
      final postBody = jsonEncode({
        "identity": identity,
        "old": oldPassword,
        "new": newPassword
      });
      var response = await _networkProvider.call(path: "/api/change_password", method: RequestMethod.post, body: postBody);
      final data = SuccessResponseModel.fromJson(json.decode(response?.data));
      return Right(data);
    } on DioException catch (e) {
      return Left(e.response?.data["message"]);
    } catch (err){
      return Left(err.toString());
    }
  }

}
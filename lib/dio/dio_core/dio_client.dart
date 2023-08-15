import 'package:batnf/dio/api_endpoint.dart';
import 'package:batnf/utilities/local_session_manager/local_session_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dio_error.dart';
import 'dio_intercepter.dart';

class NetworkProvider{
  Dio _getDioInstance(){
    var dio = Dio(BaseOptions(
      baseUrl: RoutesAndPaths.baseUrl,
      connectTimeout:const Duration(milliseconds: 60000),
      receiveTimeout:const Duration(milliseconds: 60000),
    ));
    dio.interceptors.add(LoggerInterceptor());
    dio.interceptors.add(AuthorizationInterceptor());
    dio.interceptors.add(LogInterceptor(responseBody: true,error: true,request: true,requestBody: true));
    return dio;
  }

  Future<Response?> call(
        {required String path,
        BuildContext? context,
        required  RequestMethod method,
        dynamic body=const {},
        Map<String,dynamic> queryParams=const {}
      })async{
    Response? response;
    try{
      switch(method){
        case RequestMethod.get:
          response = await _getDioInstance().get(path, queryParameters: queryParams);
          break;
        case RequestMethod.post:
          if (context != null) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          }
          response = await _getDioInstance()
              .post(path, data: body, queryParameters: queryParams);
          break;
        case RequestMethod.patch:
          if (context != null) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          }
          response = await _getDioInstance()
              .patch(path, data: body, queryParameters: queryParams);
          break;
        case RequestMethod.put:
          if (context != null) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          }
          response = await _getDioInstance()
              .put(path, data: body, queryParameters: queryParams);
          break;
        case RequestMethod.delete:
          if (context != null) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          }
          response = await _getDioInstance()
              .delete(path, data: body, queryParameters: queryParams);
          break;
      }
      return response;
    }on DioError catch (error) {
      return Future.error(ApiError.fromDio(error));
    }
  }
}


class AuthorizationInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    final token = LocalSessionManager().token;
    if (token != "" && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }
    options.headers['Content-Type'] = 'multipart/form-data';
    options.headers["Accept"] = "application/json";
    options.headers["Content-Type"] = "application/json";
    super.onRequest(options, handler);
  }
}

enum RequestMethod { get, post, put, patch, delete }
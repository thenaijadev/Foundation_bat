import 'package:dio/dio.dart';

class ApiError {
  late  String errorDescription;
  ApiError({required this.errorDescription});

  ApiError.fromDio(Object dioError) {
    _handleError(dioError);
  }
  void _handleError(Object error)async {
    if (error is DioError) {
      var dioError = error; // as DioError;
      switch (dioError.type) {
        case DioExceptionType.cancel:
          errorDescription = 'Request canceled';
          break;
        case DioExceptionType.connectionTimeout:
          errorDescription = 'Connection timeout';
          break;
        case DioExceptionType.unknown:
          errorDescription = 'Something went wrong, please check your internet connection...';
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription = 'Receiving timeout';
          break;
        case DioExceptionType.badResponse:
          if (dioError.response!.statusCode == 401) {
            errorDescription = error.response?.data?["data"]["error"].toString() ?? extractDescriptionFromResponse(error.response)!;
          } else if (dioError.response!.statusCode == 404) {
            errorDescription = error.response?.data?["data"]["error"].toString() ?? extractDescriptionFromResponse(dioError.response)!;
          } else if (dioError.response!.statusCode == 409) {
            errorDescription = error.response?.data?["data"]["error"].toString() ?? extractDescriptionFromResponse(dioError.response)!;
          }else if (dioError.response!.statusCode == 400) {
            errorDescription = error.response?.data?["data"]["error"].toString() ?? extractDescriptionFromResponse(dioError.response)!;
          } else if (dioError.response!.statusCode == 422) {
            errorDescription = error.response?.data?["data"]["error"].toString() ?? extractDescriptionFromResponse(dioError.response)!;
          }else if(dioError.response!.statusCode == 500){
            errorDescription = 'Internal Server Error';
          } else {
            errorDescription = extractDescriptionFromResponse(error.response)!;
          }
          break;
        case DioErrorType.sendTimeout:
          errorDescription = 'Something went wrong, please check your internet connection...';
          break;
        case DioErrorType.badCertificate:
          errorDescription = 'Something went wrong, please check your internet connection...';
          break;
        case DioErrorType.connectionError:
          errorDescription = 'Something went wrong, please check your internet connection...';
          break;
      }
    } else {
      errorDescription = 'Something went wrong, please try again...';
    }
  }

  String? extractDescriptionFromResponse(Response? response) {
    String? message;
    try {
      if(response?.data['data']['error'] != null) {
        message = '${message!}. ${response!.data["data"]["error"]}';
      }
      if (response?.data != null && response!.data['message'] != null) {
        message = response.data['message'];

        if(response.data['error'] != null) {
          message = '${message!}. ${response.data['error']}';
        }

      } else {
        message = response!.statusMessage;
      }

    } catch (error) {
      message = response?.statusMessage ?? error.toString();
    }

    return message;
  }

  @override
  String toString() => errorDescription;
}


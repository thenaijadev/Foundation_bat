import 'dart:convert';
import 'dart:developer';
import 'package:batnf/dio/api_endpoint.dart';
import 'package:batnf/dio/dio_core/dio_client.dart';
import 'package:batnf/features/home/data/projects/model/events/event_details_model.dart';
import 'package:batnf/features/home/data/projects/model/events/events_response_model.dart';
import 'package:batnf/features/home/data/projects/model/response/response_data_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'events.dart';

class GetEventImpl extends EventRepository{
  final NetworkProvider _networkProvider = NetworkProvider();
  @override
  Future<Either<String, List<EventsResponseModel>>> getEvents() async{
    try {
      var response = await _networkProvider.call(path: RoutesAndPaths.allEvents, method: RequestMethod.get);
      if (response!.statusCode == 200){
        log(response.data);
        List<EventsResponseModel> eventList =
        List<EventsResponseModel>.from(json.decode(response.data).map((x) => EventsResponseModel.fromJson(x)));
        return Right(eventList);
      } else {
        return Left(response.data['message']);
      }
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, GetEventByIdResponseModel>> getEventById({required String id}) async {
    try {
      var response = await _networkProvider.call(path: "/api/getSingleEvent/$id", method: RequestMethod.get);
      final data = GetEventByIdResponseModel.fromJson(json.decode(response?.data));
      return Right(data);
    } on DioException catch (e) {
      return Left(e.response?.data["message"]);
    } catch (err){
      return Left(err.toString());
    }
  }

  @override
  Future<Either<String, SuccessResponseModel>> registerEvent({required String date, required int eventId, required int userId}) async {
    try {
      final postBody = jsonEncode({
        "userId": userId,
        "eventId": eventId,
        "registerDate": date
      });
      var response = await _networkProvider.call(path: "/api/attendEvent/", method: RequestMethod.post, body: postBody);
      final data = SuccessResponseModel.fromJson(json.decode(response?.data));
      if(response!.data["status"].toString() == "200"){
        log("Success");
        return Right(data);
      }else{
        log("error");
        return Left(response.data['message']);
      }
    } on DioException catch (e) {
      return Left(e.response?.data["message"]);
    } catch (err){
      return Left(err.toString());
    }
  }

}
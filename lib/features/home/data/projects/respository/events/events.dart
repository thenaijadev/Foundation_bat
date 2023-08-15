import 'package:batnf/features/home/data/projects/model/events/event_details_model.dart';
import 'package:batnf/features/home/data/projects/model/events/events_response_model.dart';
import 'package:batnf/features/home/data/projects/model/response/response_data_model.dart';
import 'package:dartz/dartz.dart';

abstract class EventRepository {
  Future<Either<String,List<EventsResponseModel>>> getEvents();
  Future<Either<String,GetEventByIdResponseModel>> getEventById({required String id});
  Future<Either<String,SuccessResponseModel>> registerEvent({required int userId, required int eventId, required String date});
}
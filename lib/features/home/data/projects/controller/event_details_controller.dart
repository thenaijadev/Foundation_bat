import 'dart:convert';
import 'package:batnf/core/state/view_state.dart';
import 'package:batnf/dio/dio_core/dio_client.dart';
import 'package:batnf/features/home/data/projects/model/events/event_details_model.dart';
import 'package:batnf/features/home/data/projects/model/response/response_data_model.dart';
import 'package:batnf/features/home/data/projects/respository/events/events.dart';
import 'package:batnf/features/home/presentation/widgets/flush_bar.dart';
import 'package:batnf/features/home/presentation/widgets/progress_indicator.dart';
import 'package:batnf/utilities/injector.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EventDetailsController extends GetxController{
  final EventRepository _eventRepository = sl<EventRepository>();

  ViewState<GetEventByIdResponseModel> eventDetailsDateStateView = ViewState(state: ResponseState.empty);
  void _setEventDetailsNewsState(ViewState<GetEventByIdResponseModel> eventDetailsDateStateView) {
    this.eventDetailsDateStateView = eventDetailsDateStateView;
  }
  String? errorMessage;
  void getEventById({required String id}) async {
    try{
      _setEventDetailsNewsState(ViewState.loading());
      update();
      Either<String, GetEventByIdResponseModel> either = await _eventRepository.getEventById(id: id);
      either.fold((l){
        _setEventDetailsNewsState(ViewState.error(l));
        update();
        return _setEventDetailsNewsState(ViewState.error(l));
      }, (r){
        _setEventDetailsNewsState(ViewState.complete(r));
        update();
        return _setEventDetailsNewsState(ViewState.complete(r));
      });
      update();
    }catch(e){
      _setEventDetailsNewsState(ViewState.error(e.toString()));
      errorMessage = e.toString();
      update();
      _setEventDetailsNewsState(ViewState.error(e.toString()));
    }
  }


  Future<void> registerEvent({required int userId, required int eventId, required String date, required BuildContext context})async{
    progressIndicator(context);
    try {
      final postBody = jsonEncode({
        "userId": userId,
        "eventId": eventId,
        "registerDate": date
      });
      var response = await NetworkProvider().call(path: "/api/attendEvent/", method: RequestMethod.post, body: postBody);
      final data = SuccessResponseModel.fromJson(json.decode(response?.data));
      // if(response!.data["status"].toString() == "200"){
        WidgetsBinding.instance.addPostFrameCallback((_){
          Navigator.pop(Get.context!);
          FlushBar(Get.context!, data.message ?? "", "Success").showSuccessBar;
        });
      // }else{
      //   WidgetsBinding.instance.addPostFrameCallback((_){
      //     Navigator.of(Get.context!).pop();
      //     InfoSnackBar.showErrorSnackBar(
      //         Get.context!, "Request Error: ${response!.data["message"] ?? "Please check your credentials and resend"}");
      //   });
      //
      // }
    } on DioException catch (e) {
      Navigator.of(Get.context!).pop();
      FlushBar(Get.context!, e.response?.data["message"], "Error").showErrorBar;
      throw e.response?.data["message"];
    } catch (err){
      Navigator.of(Get.context!).pop();
      FlushBar(Get.context!, err.toString(), "Error").showErrorBar;
      throw err.toString();
    }
  }

  // ViewState<SuccessResponseModel> registerEventsDateStateView = ViewState(state: ResponseState.empty);
  // void _setRegisterEventNewsState(ViewState<SuccessResponseModel> registerEventsDateStateView) {
  //   this.registerEventsDateStateView = registerEventsDateStateView;
  // }
  // Future<void> registerEvent({required int userId, required int eventId, required String date}) async {
  //   try{
  //     // _setRegisterEventNewsState(ViewState.loading());
  //     // update();
  //     Either<String, SuccessResponseModel> either = await _eventRepository.registerEvent(userId: userId, eventId: eventId, date: date);
  //     either.f((l){
  //       errorMessage = l.toString();
  //       log("This is the error state");
  //       _setRegisterEventNewsState(ViewState.error(l));
  //       update();
  //       return _setRegisterEventNewsState(ViewState.error(l));
  //     }, (r){
  //       log("3");
  //       _setRegisterEventNewsState(ViewState.complete(r));
  //       update();
  //       return _setRegisterEventNewsState(ViewState.complete(r));
  //     });
  //     update();
  //   }catch(e){
  //     errorMessage = e.toString();
  //     // _setRegisterEventNewsState(ViewState.error(e.toString()));
  //     // update();
  //     // _setRegisterEventNewsState(ViewState.error(e.toString()));
  //   }
  // }
}
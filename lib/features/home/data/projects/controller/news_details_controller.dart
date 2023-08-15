import 'dart:developer';
import 'package:batnf/core/state/view_state.dart';
import 'package:batnf/features/home/data/projects/model/news/news_details_model.dart';
import 'package:batnf/features/home/data/projects/respository/media_centre/news.dart';
import 'package:batnf/utilities/injector.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class NewsDetailsController extends GetxController{
  final NewsRepository _newsRepository = sl<NewsRepository>();

  ViewState<GetNewsByIdResponseModel> newsDetailsDateStateView = ViewState(state: ResponseState.empty);
  void _setNewsDetailsNewsState(ViewState<GetNewsByIdResponseModel> newsDetailsDateStateView) {
    this.newsDetailsDateStateView = newsDetailsDateStateView;
  }
  void getNewsById({required String id}) async {
    try{
      log("1");
      _setNewsDetailsNewsState(ViewState.loading());
      update();
      Either<String, GetNewsByIdResponseModel> either = await _newsRepository.getNewsById(id: id);
      either.fold((l){
        _setNewsDetailsNewsState(ViewState.error(l));
        update();
        return _setNewsDetailsNewsState(ViewState.error(l));
      }, (r){
        _setNewsDetailsNewsState(ViewState.complete(r));
        update();
        return _setNewsDetailsNewsState(ViewState.complete(r));
      });
      update();
    }catch(e){
      log(e.toString());
      _setNewsDetailsNewsState(ViewState.error(e.toString()));
      update();
      _setNewsDetailsNewsState(ViewState.error(e.toString()));
    }
  }
}
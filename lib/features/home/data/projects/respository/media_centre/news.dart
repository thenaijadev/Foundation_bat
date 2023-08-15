import 'package:batnf/features/home/data/projects/model/news/news_details_model.dart';
import 'package:batnf/features/home/data/projects/model/news/news_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class NewsRepository {
  Future<Either<String,List<NewsResponseModel>>> getNews();
  Future<Either<String,GetNewsByIdResponseModel>> getNewsById({required String id});
}
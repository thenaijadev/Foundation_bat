import 'package:batnf/Models/news_model.dart';
import 'package:batnf/services/news_services.dart';
import 'package:flutter/widgets.dart';

class NewsProvider extends ChangeNotifier {
  List<NewsModel>? allNews;

  getAllNews() async {
    allNews = await AppNews().getAllNews();
    notifyListeners();
  }
}

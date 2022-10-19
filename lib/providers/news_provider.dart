import 'package:batnf/Models/news_model.dart';
import 'package:batnf/services/news_services.dart';
import 'package:flutter/widgets.dart';
import 'package:batnf/Models/files.dart';

class NewsProvider extends ChangeNotifier {
  List<NewsModel>? allNews = 
  [
    NewsModel(files: [
      Files(fileUrl: 'fileUrl',
       fileExt: 'fileExt')],
      newsImage: 'newsImage', 
      information: 'information', 
      title: 'title', 
      newsId: 'newsId', 
      entryDate: 'entryDate', 
      adminId: 'adminId', 
      status: 'status')
  ];

  getAllNews() async {
    allNews = await AppNews().getAllNews();
    notifyListeners();
  }
}

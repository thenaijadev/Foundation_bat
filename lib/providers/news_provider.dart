import 'package:batnf/Models/news_model.dart';
import 'package:batnf/services/news_services.dart';
import 'package:flutter/widgets.dart';

class NewsProvider extends ChangeNotifier {
  //allNews does the same thing as you created it to do
  List<NewsModel>? allNews;

  //This holds the result of the search. If the search is empty,
  //it has the same value as the allNews
  List<NewsModel>? searchResult;

  //This holds the latest String that was inputted in the search box by the user
  //This string is important so that when the user refreshes the page and loads new
  //news, it will still be filtered based on what is currently in the search box.
  String searchString = '';

  getAllNews() async {
    allNews = await AppNews().getAllNews();

    //After getting all news, I call the search function with the value that was
    //last inputted by the user. if nothing has been inputted, it is an empty string
    search(searchString);
  }

  search(searchString) async {
    ///this updates the local [searchString] with the current search string.
    this.searchString = searchString;

    //end if allNews is null
    if (allNews == null) return;

    //A local variable to hold the search result temporarily.
    List<NewsModel> news = [];

    //set search result to the value of allNews if the search string is empty.
    //i.e nothing is in the search box
    if (searchString.trim().isEmpty) {
      searchResult = allNews!;
    }
    //if the search box is not empty, perform search and update the local search result.

    //currently, searching only works for titles. you can add other fields later.
    else {
      for (NewsModel newsItem in allNews!) {
        if (newsItem.title.toLowerCase().contains(searchString.toLowerCase())) {
          news.add(newsItem);
        }
      }
      //set the value of the search result to the local value
      searchResult = news;
    }

    //notify listeners that the value has changed.
    await Future.delayed(const Duration(milliseconds: 1));
    notifyListeners();
  }
}

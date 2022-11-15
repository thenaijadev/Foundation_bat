
import 'package:flutter/widgets.dart';
import '../Models/inprogress_model.dart';
import '../services/inprogress_services.dart';

class InprogressProvider extends ChangeNotifier {
  List<InprogressModel>? allInprogressProjects;
  List<InprogressModel>? searchResult;
   String searchString = '';
   
  getInprogressProjects() async {
    allInprogressProjects =
        await AppInprogressProjects().getInprogressProjects();
        search(searchString);
  }

  search(String searchString) async {
    ///this updates the local [searchString] with the current search string.
    this.searchString = searchString;

    //end if allInprogressProjects is null
    if (allInprogressProjects == null) return;

    //A local variable to hold the search result temporarily.
    List<InprogressModel> project = [];

    //set search result to the value of allInprogressProjects if the search string is empty.
    //i.e nothing is in the search box
    if (searchString.trim().isEmpty) {
      searchResult = allInprogressProjects!;
    }
    //if the search box is not empty, perform search and update the local search result.

    //currently, searching only works for titles. you can add other fields later.
    else {
      for (InprogressModel projectItem in allInprogressProjects!) {
        if (projectItem.projectTitle.toLowerCase().contains(searchString.toLowerCase())) {
          project.add(projectItem);
        }
      }
      //set the value of the search result to the local value
      searchResult = project;
    }

    //notify listeners that the value has changed.
    await Future.delayed(const Duration(milliseconds: 1));
    notifyListeners();
  }
}

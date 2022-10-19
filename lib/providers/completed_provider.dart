import 'package:flutter/widgets.dart';
import '../Models/completed_model.dart';
import '../Models/files.dart';
import '../services/completed_service.dart';

class CompletedProvider extends ChangeNotifier {
  List<CompletedModel>? allCompletedProjects = 
  [
    CompletedModel(files: [
      Files(fileUrl: 'fileUrl',
       fileExt: 'fileExt')
       ],
     projectId: 'projectId',
      projectTitle: 'projectTitle',
      projectDescription: 'projectDescription',
      projectImage: 'projectImage', 
      projectStartDate: 'projectStartDate', 
      projectEndDate: 'projectEndDate', 
      projectVenue: 'projectVenue', 
      projectLocation: 'projectLocation', 
      projectStatus: 'projectStatus')
  ];

  getCompletedProjects() async {
    allCompletedProjects =
        await AppCompletedProjects().getCompletedProjects();
    notifyListeners();
  }
}

import 'package:flutter/widgets.dart';
import '../Models/pending_model.dart';
import '../services/pending_services.dart';
import 'package:batnf/Models/files.dart';

class PendingProvider extends ChangeNotifier {
  List<PendingModel>? allPendingProjects
  = [
    PendingModel(files: [
      Files(fileUrl: 'fileUrl', 
      fileExt: 'fileExt', thumbnail: 'thumbnail')], 
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

  getPendingProjects() async {
    allPendingProjects = await AppPendingProjects().getPendingProjects();
    notifyListeners();
  }
}

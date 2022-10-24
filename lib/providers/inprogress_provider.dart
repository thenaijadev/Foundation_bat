import 'package:batnf/Models/files.dart';
import 'package:flutter/widgets.dart';
import '../Models/inprogress_model.dart';
import '../services/inprogress_services.dart';

class InprogressProvider extends ChangeNotifier {
  List<InprogressModel>? allInprogressProjects
  = [
    InprogressModel(
          projectid: 'projectId',
         projectTitle: 'projectTitle',
          projectDescription: 'projectDescription',
           projectImage: 'projectImage',
            projectStartDate: 'projectStartDate',
             projectEndDate: 'projectEndDate',
              projectVenue: 'projectVenue',
               projectLocation: 'projectLocation',
                projectStatus: 'projectStatus',
                files: [
                  Files(
     fileUrl: 'fileUrl',
     fileExt: 'fileExt', thumbnail: 'thumbnail')
                ] 
     )
  ];

  getInprogressProjects() async {
    allInprogressProjects =
        await AppInprogressProjects().getInprogressProjects();
    notifyListeners();
  }
}

import 'package:batnf/Models/files.dart';
import 'package:batnf/Models/inprogress.dart';
import 'package:flutter/widgets.dart';
import '../Models/inprogress_model.dart';
import '../services/inprogress_services.dart';

class InprogressProvider extends ChangeNotifier {
  List<InprogressModel>? allInprogressProjects = [
    InprogressModel(
      progress: [
        Inprogress(
          projectId: 'projectId',
         projectTitle: 'projectTitle',
          projectDescription: 'projectDescription',
           projectImage: 'projectImage',
            projectStartDate: 'projectStartDate',
             projectEndDate: 'projectEndDate',
              projectVenue: 'projectVenue',
               projectLocation: 'projectLocation',
                projectStatus: 'projectStatus')],

     projectfiles: [
      Files(
      projectId: 'projectId',
     fileUrl: 'fileUrl',
     fileExt: 'fileExt')])
  ];


  getInprogressProjects() async {
    allInprogressProjects =
        await AppInprogressProjects().getInprogressProjects();
    notifyListeners();
    
  }
}

import 'package:batnf/Models/files.dart';
import 'package:batnf/Models/inprogress.dart';
import 'package:flutter/widgets.dart';
import '../Models/inprogress_model.dart';
import '../services/inprogress_services.dart';

class InprogressProvider extends ChangeNotifier {
  List<InprogressModel>? allInprogressProjects;
  // List<Files>? allInprogressPic;
  // List<Inprogress>? allInprogressDetails;


  getInprogressProjects() async {
    allInprogressProjects =
        await AppInprogressProjects().getInprogressProjects();
        // allInprogressPic =
        // (await AppInprogressProjects().getInprogressProjects()).cast<Files>();
        // allInprogressDetails =
        // (await AppInprogressProjects().getInprogressProjects()).cast<Inprogress>();
    notifyListeners();
    
  }
}

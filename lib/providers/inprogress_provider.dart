import 'package:batnf/Models/files.dart';
import 'package:batnf/Models/inprogress.dart';
import 'package:flutter/widgets.dart';
import '../Models/inprogress_model.dart';
import '../services/inprogress_services.dart';

class InprogressProvider extends ChangeNotifier {
  List<InprogressModel>? allInprogressProjects = [
    InprogressModel(
      progressdetails: [],
     projectfiles: [])
  ];


  getInprogressProjects() async {
    allInprogressProjects =
        await AppInprogressProjects().getInprogressProjects();
    notifyListeners();
    
  }
}

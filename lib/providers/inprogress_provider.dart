
import 'package:flutter/widgets.dart';
import '../Models/inprogress_model.dart';
import '../services/inprogress_services.dart';

class InprogressProvider extends ChangeNotifier {
  List<InprogressModel>? allInprogressProjects;

  getInprogressProjects() async {
   allInprogressProjects = await AppInprogressProjects().getInprogressProjects();
    notifyListeners();
  }
}

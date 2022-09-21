import 'package:flutter/widgets.dart';
import '../Models/completed_model.dart';
import '../services/completed_service.dart';

class CompletedProvider extends ChangeNotifier {
  List<CompletedModel>? allCompletedProjects;

  getCompletedProjects() async {
    allCompletedProjects =
        await AppCompletedProjects().getCompletedProjects();
    notifyListeners();
  }
}

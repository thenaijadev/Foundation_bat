import 'package:flutter/widgets.dart';
import '../Models/pending_model.dart';
import '../services/pending_services.dart';

class PendingProvider extends ChangeNotifier {
  List<PendingModel>? allPendingProjects;

  getPendingProjects() async {
    allPendingProjects = await AppPendingProjects().getPendingProjects();
    notifyListeners();
  }
}

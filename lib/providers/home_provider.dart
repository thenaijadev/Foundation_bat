import 'package:flutter/widgets.dart';
import '../Models/home_model.dart';
import '../services/home_service.dart';



class HomeProvider extends ChangeNotifier {
  List<HomeModel>? allHomeProjects;

  getHomeProjects() async {
    allHomeProjects = await AppHomeProjects().getHomeProjects();
    notifyListeners();
  }
}

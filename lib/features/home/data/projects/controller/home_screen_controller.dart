import 'package:get/get.dart';

class HomeScreenController extends GetxController{
  int selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }

  void move(int index) {
    selectedIndex = index;
    update();
  }
}
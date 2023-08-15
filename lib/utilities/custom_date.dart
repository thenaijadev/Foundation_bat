import 'package:jiffy/jiffy.dart';

class CustomDate{
  static String slash(String date) {
    final formattedDate = Jiffy(date).yMMMdjm;
    return formattedDate;
  }
}

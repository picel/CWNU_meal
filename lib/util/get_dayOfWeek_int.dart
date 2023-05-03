import 'package:intl/intl.dart';

class DayOfWeekINT {
  int weekdayToInt(bool isDorm) {
    String weekday = DateFormat('EEEE').format(DateTime.now()).toLowerCase();

    int result = 0;
    switch (weekday) {
      case 'monday':
        result = 0;
        break;
      case 'tuesday':
        result = 1;
        break;
      case 'wednesday':
        result = 2;
        break;
      case 'thursday':
        result = 3;
        break;
      case 'friday':
        result = 4;
        break;
      case 'saturday':
        result = 5;
        break;
      case 'sunday':
        result = 6;
        break;
      default:
        result = 0;
        break;
    }
    if (!isDorm && result >= 5) {
      result = 0;
    }
    return result;
  }
}

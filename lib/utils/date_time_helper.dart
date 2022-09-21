
import 'package:intl/intl.dart';

class DateTimeHelper {
  static String getGreeting() {
    DateTime now = DateTime.now();
    var timeNow = int.parse(DateFormat('kk').format(now));
    var message = '';
    if (timeNow <= 12) {
      message = 'Good Morning 🌞';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      message = 'Good Afternoon 🌤';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      message = 'Good Evening 🌜';
    } else {
      message = 'Good Night 🌛';
    }

    return message;
  }

  static String convertDate(String inputDate) {
    var inputFormat = DateFormat('dd-MM-yyyy');
    var date1 = inputFormat.parse(inputDate);

    var outputFormat = DateFormat('MMM dd,yyyy | EEEE');
    var date2 = outputFormat.format(date1);
    return date2.toString();
  }

  static String getCurrentDate({String format = 'EEE,dd MMM'}) {
    var date1 = DateTime.now();

    var outputFormat = DateFormat(format);
    var date2 = outputFormat.format(date1);
    return date2.toString();
  }

  static String getCurrentTime() {
    var date1 = DateTime.now();

    var outputFormat = DateFormat('dd-MM-yyy hh:mm:ss a');
    var date2 = outputFormat.format(date1);
    return date2.toString();
  }

  static String formatTime(String time, String oFormat) {
    final now = DateTime.now();

    final dt = DateTime(now.year, now.month, now.day);
    final format = DateFormat(oFormat); //"6:00 AM"
    return format.format(dt);
  }

  static String formatDate(DateTime dateTime, String format) {
    return DateFormat(format).format(dateTime);
  }

}

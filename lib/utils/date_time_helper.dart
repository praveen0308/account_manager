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

  static String prettyDuration(int milliseconds) {
    Duration duration = Duration(milliseconds: milliseconds);
    var components = <String>[];

    var days = duration.inDays;

    if (days != 0) {
      if (days >= 30) {
        components.add("${days~/ 30} Months,");
        days = days%30;
        components.add('$days Days');
      } else {
        components.add('$days Days');
      }
    }
    /*var hours = duration.inHours % 24;
    if (hours != 0) {
      components.add('${hours}h');
    }
    var minutes = duration.inMinutes % 60;
    if (minutes != 0) {
      components.add('${minutes}m');
    }*/

    var seconds = duration.inSeconds % 60;
    var centiseconds = (duration.inMilliseconds % 1000) ~/ 10;
    /*if (components.isEmpty || seconds != 0 || centiseconds != 0) {
      components.add('$seconds');
      if (centiseconds != 0) {
        components.add('.');
        components.add(centiseconds.toString().padLeft(2, '0'));
      }
      components.add('s');
    }*/
    return components.join();
  }

  static List<int> getDates(int filterId) {
    var today = DateTime.now();
    int from = 0;
    int to = today.millisecondsSinceEpoch;

    switch (filterId) {
      case 2:
        {
          from = DateTime(today.year, today.month, today.day - 7)
              .millisecondsSinceEpoch;
        }
        break;
      case 3:
        {
          from = DateTime(today.year, today.month, today.day - 30)
              .millisecondsSinceEpoch;
        }
        break;
      case 4:
        {
          from = DateTime(today.year, today.month, today.day - 90)
              .millisecondsSinceEpoch;
        }
        break;
      case 5:
        {
          from = DateTime(today.year - 1, today.month, today.day)
              .millisecondsSinceEpoch;
        }
        break;
    }

    return [from, to];
  }
}

extension DateBounds on DateTime {
  int get firstMillisecondOfDay =>
      DateTime(year, month, day).millisecondsSinceEpoch;

  int get lastMillisecondOfDay =>
      DateTime(year, month, day + 1).millisecondsSinceEpoch;

  int get firstMillisecondOfMonth =>
      DateTime(year, month, 1).millisecondsSinceEpoch;

  int get lastMillisecondOfMonth => month < 12
      ? DateTime(year, month + 1, 1, 00, 00, 00, -1).millisecondsSinceEpoch
      : DateTime(year + 1, 1, 1, 00, 00, 00, -1).millisecondsSinceEpoch;

  int get firstMillisecondOfYear => DateTime(year).millisecondsSinceEpoch;

  int get lastMillisecondOfYear =>
      DateTime(year + 1, 1, 0).millisecondsSinceEpoch;
}

enum DateFilter { daily, monthly, yearly }

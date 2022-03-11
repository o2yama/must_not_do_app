import 'package:intl/intl.dart';

class Formatter {
  static String dateFormat(DateTime date) {
    final outputFormat = DateFormat('yyyy/MM/dd');
    return outputFormat.format(date);
  }
}

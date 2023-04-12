import 'package:intl/intl.dart';

import '../constant/app_strings.dart';

const dateTimeYMDEJP = 'yyyy年M月d日（E）';
const serverDateFormat = 'yyyy-MM-dd';

/// 利用する場合は以下を記載
/// import 'package:lispo_app/util/date_formatter.dart';
extension DateTimeExt on DateTime {
  String toFormatText({
    String format = 'yyyy/MM/dd HH:mm:ss yMMMEd',
  }) {
    return DateFormat(format, 'ja_JP').format(this);
  }

  String dateTimeToYMDJP() => toFormatText(format: 'yyyy年M月d日');

  String dateTimeToYMJP() => toFormatText(format: 'yyyy年M月');

  String dateTimeToYJP() => toFormatText(format: 'yyyy年');

  String dateTimeToMDEJP() => toFormatText(format: 'M月d日（E）');

  String dateTimeToYMDEJP() => toFormatText(format: 'yyyy年M月d日（E）');

  String dateTimeToMDESlash() => toFormatText(format: 'M/d（E）');

  String dateTimeToMDEJPHmm() => toFormatText(format: 'M月d日（E）H:mm');

  String dateTimeToYMDEHmm() => toFormatText(format: 'yyyy/M/d（E）H:mm');

  String dateTimeToYMDHmm() => toFormatText(format: 'yyyy/M/d H:mm');

  String dateTimeToYMDE() => toFormatText(format: 'yyyy/M/d（E）');

  String dateTimeToYMDHmmJP() => toFormatText(format: 'yyyy年M月d日 H:mm');

  String dateTimeToYMDEHmmJP() => toFormatText(format: 'yyyy年M月d日（E）H:mm');

  String dateTimeToMdHm() => toFormatText(format: 'M/d H:mm');

  String dateTimeToyMMMEd() => toFormatText(format: 'yMMMEd');

  String toServerDate() => toFormatText(format: serverDateFormat);

  String toServerDateTime() => toFormatText(format: 'yyyy-MM-dd HH:mm');

  String toServerDateTimeSecond() => toFormatText(format: 'yyyy-MM-dd HH:mm:ss');

  String dateTimeToHmm() => toFormatText(format: 'H:mm');

  String dateTimeToHHmm() => toFormatText(format: 'HH:mm');

  String dateTimeSlash() => toFormatText(format: 'yyyy/MM/dd H:mm');

  String dateTimeEJP() => toFormatText(format: '(E)');

  String dateTimeToMd() => toFormatText(format: 'M/d');

  String fromNow() {
    final difference = DateTime.now().difference(this);
    final day = difference.inDays;

    if (day <= 30) {
      return '${difference.inDays.toString()}${Strings.beforeDayText}';
    } else if (day < 365) {
      return '${(difference.inHours / 720).floor()}${Strings.beforeMonthText}';
    } else {
      return Strings.beforeOneYearsText;
    }
  }

  DateTime dateOnly() => DateTime(year, month, day);

  bool isSameTimeAboutMinutes(DateTime other) {
    return year == other.year &&
        month == other.month &&
        day == other.day &&
        hour == other.hour &&
        minute == other.minute;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }
}

extension ParseDateTime on String {
  DateTime _parse({
    required String format,
  }) {
    return DateFormat(format, 'ja_JP').parse(this);
  }

  DateTime parseToDate() => _parse(format: serverDateFormat);
}

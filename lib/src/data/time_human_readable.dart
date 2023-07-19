import 'package:dartx/dartx.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

final _timeFormatter = DateFormat.Hm();

String _formatWeek(int weekday) => switch (weekday) {
      1 => '星期一',
      2 => '星期二',
      3 => '星期三',
      4 => '星期四',
      5 => '星期五',
      6 => '星期六',
      7 => '星期日',
      _ => throw UnimplementedError(''),
    };

/// 时间人类可读
extension TimeHumanReadable on DateTime {
  @visibleForTesting
  static var nowProvider = () => DateTime.now();

  /// 如果时间在一分钟内，则显示多少秒前
  ///
  /// 如果时间在一天内，显示时 + 分
  ///
  /// 如果时间在本周内，则显示星期几 + 时 + 分
  ///
  /// 如果时间在本月，显示日 + 时 + 分
  ///
  /// 如果时间在今年，显示月 + 日 + 时 + 分
  String get shortString {
    final now = nowProvider();

    var diffNowInSeconds = difference(now).inSeconds;
    if (diffNowInSeconds.abs() < 60) {
      if (diffNowInSeconds < 0) {
        return '${diffNowInSeconds.abs()}秒前';
      } else {
        return '$diffNowInSeconds秒内';
      }
    } else {
      final timeString = _timeFormatter.format(this);
      if (isBefore(now.copyWith(
              hour: 23,
              minute: 59,
              second: 59,
              millisecond: 999,
              microsecond: 999)) &&
          isAfter(
            now
                .copyWith(
                    hour: 0,
                    minute: 0,
                    second: 0,
                    millisecond: 0,
                    microsecond: 0)
                .subtract(
                  const Duration(microseconds: 1),
                ),
          )) {
        return timeString;
      } else if (isBefore(now.add(const Duration(days: 1)).copyWith(
          hour: 23,
          minute: 59,
          second: 59,
          millisecond: 999,
          microsecond: 999)) &&
          isAfter(
            now.add(const Duration(days: 1))
                .copyWith(
                hour: 0,
                minute: 0,
                second: 0,
                millisecond: 0,
                microsecond: 0)
                .subtract(
              const Duration(microseconds: 1),
            ),
          )) {
        return '明天 $timeString';
      } else if (isBefore(now.subtract(const Duration(days: 1)).copyWith(
          hour: 23,
          minute: 59,
          second: 59,
          millisecond: 999,
          microsecond: 999)) &&
          isAfter(
            now.subtract(const Duration(days: 1))
                .copyWith(
                hour: 0,
                minute: 0,
                second: 0,
                millisecond: 0,
                microsecond: 0)
                .subtract(
              const Duration(microseconds: 1),
            ),
          )) {
        return '昨天 $timeString';
      } else if (isBefore(now.lastDayOfWeek.copyWith(
              hour: 23,
              minute: 59,
              second: 59,
              millisecond: 999,
              microsecond: 999)) &&
          isAfter(
            now.firstDayOfWeek
                .copyWith(
                    hour: 0,
                    minute: 0,
                    second: 0,
                    millisecond: 0,
                    microsecond: 0)
                .subtract(
                  const Duration(microseconds: 1),
                ),
          )) {
        return '${_formatWeek(weekday)} $timeString';
      } else if (isBefore(now.lastDayOfMonth.copyWith(
              hour: 23,
              minute: 59,
              second: 59,
              millisecond: 999,
              microsecond: 999)) &&
          isAfter(
            now.firstDayOfMonth
                .copyWith(
                    hour: 0,
                    minute: 0,
                    second: 0,
                    millisecond: 0,
                    microsecond: 0)
                .subtract(
                  const Duration(microseconds: 1),
                ),
          )) {
        return '$day日 $timeString';
      } else if (isBefore(now.lastDayOfYear.copyWith(
              hour: 23,
              minute: 59,
              second: 59,
              microsecond: 999,
              millisecond: 999)) &&
          isAfter(
            now.firstDayOfYear
                .copyWith(
                    hour: 0,
                    minute: 0,
                    second: 0,
                    millisecond: 0,
                    microsecond: 0)
                .subtract(
                  const Duration(microseconds: 1),
                ),
          )) {
        return '$month月$day日 $timeString';
      } else {
        return '$year年$month月$day日 $timeString';
      }
    }
  }
}

import 'package:common/src/data/time_human_readable.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
    group('TimeHumanReadable测试', () {
        /// 7.15是周六
        TimeHumanReadable.nowProvider = () => DateTime(2023, 7, 15, 9, 30, 30);
        test('shortString 在60秒内', () {
            expect(DateTime(2023, 7, 15, 9, 29, 31).shortString, '59秒前');
            expect(DateTime(2023, 7, 15, 9, 31, 29).shortString, '59秒内');
        });
        test('shortString 在今天内', () {
            expect(DateTime(2023, 7, 15, 9, 35, 29).shortString, '09:35');
            expect(DateTime(2023, 7, 15, 9, 00, 29).shortString, '09:00');
            expect(DateTime(2023, 7, 15, 0, 00, 00).shortString, '00:00');
            expect(DateTime(2023, 7, 15, 23, 59, 59).shortString, '23:59');
        });
        test('shortString 在明天', () {
            expect(DateTime(2023, 7, 16, 9, 35, 29).shortString, '明天 09:35');
            expect(DateTime(2023, 7, 16, 9, 00, 29).shortString, '明天 09:00');
            expect(DateTime(2023, 7, 16, 0, 00, 00).shortString, '明天 00:00');
            expect(DateTime(2023, 7, 16, 23, 59, 59).shortString, '明天 23:59');
        });
        test('shortString 在昨天', () {
            expect(DateTime(2023, 7, 14, 9, 35, 29).shortString, '昨天 09:35');
            expect(DateTime(2023, 7, 14, 9, 00, 29).shortString, '昨天 09:00');
            expect(DateTime(2023, 7, 14, 0, 00, 00).shortString, '昨天 00:00');
            expect(DateTime(2023, 7, 14, 23, 59, 59).shortString, '昨天 23:59');
        });
        test('shortString 在本周内', () {
            expect(DateTime(2023, 7, 10, 0, 0, 0).shortString, '星期一 00:00');
            expect(DateTime(2023, 7, 11, 0, 0, 0).shortString, '星期二 00:00');
            expect(DateTime(2023, 7, 12, 0, 0, 0).shortString, '星期三 00:00');
            expect(DateTime(2023, 7, 13, 0, 0, 0).shortString, '星期四 00:00');
        });
        test('shortString 在本月内', () {
            expect(DateTime(2023, 7, 1, 0, 0, 0).shortString, '1日 00:00');
            expect(DateTime(2023, 7, 31, 23, 59, 59).shortString, '31日 23:59');
        });
        test('shortString 在今年内', () {
            expect(DateTime(2023, 1, 1, 0, 0, 0).shortString, '1月1日 00:00');
            expect(DateTime(2023, 12, 31, 23, 59, 59).shortString, '12月31日 23:59');
        });
        test('shortString 不是当年', () {
            expect(DateTime(2024, 1, 1, 0, 0, 0).shortString, '2024年1月1日 00:00');
            expect(DateTime(2022, 12, 31, 23, 59, 59).shortString, '2022年12月31日 23:59');
        });
    });
}

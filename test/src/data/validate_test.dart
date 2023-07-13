import 'package:common/common.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StringValidateTest', () {
    test('validateNotEmpty', () {
      expect('nullList'.validateNotEmpty('文本为空'),
          'nullList');
      expect(() => ''.validateNotEmpty('文本为空'),
          throwsA('文本为空'));
    });

    test('validateLength', () {
      expect('123'.validateNotEmpty('长度不为2'),
          '123');
      expect(() => '123'.validateLength(2, '长度不为2'),
          throwsA('长度不为2'));
    });

    test('validateDouble', () {
      expect(' '.validateDouble(''), isNull, reason: '空文本，输出空');
      expect('1'.validateDouble(''), 1);
      expect(() => '1a'.validateDouble('数字格式不正确'), throwsA('数字格式不正确'));
    });

    test('validateInt', () {
      expect(' '.validateInt(''), isNull, reason: '空文本，输出空');
      expect('1'.validateInt(''), 1);
      expect(() => '1a'.validateInt('数字格式不正确'), throwsA('数字格式不正确'));
    });
  });

  group('AnyValidate', () {
    test('validateInt', () {
      expect(123.validateEquals(123, '数字不一样'), 123);
      expect(() => 1234.validateEquals(123, '数字不一样'), throwsA('数字不一样'));
    });
    test('validateNotNull', () {
      expect(123.validateNotNull('不能为空'), 123);
      expect(() => null.validateNotNull('不能为空'), throwsA('不能为空'));
    });
  });

  group('IterableValidate', () {
    test('validateInt', () {
      expect([0, 1].validateNotEmpty('列表不能为空'), [0, 1]);
      expect(() => [].validateNotEmpty('列表不能为空'), throwsA('列表不能为空'));
      List? nullList;
      expect(() => nullList.validateNotEmpty('列表不能为空'), throwsA('列表不能为空'));
    });
    test('validateNotNull', () {
      expect(123.validateNotNull('不能为空'), 123);
      expect(() => null.validateNotNull('不能为空'), throwsA('不能为空'));
    });
  });
}
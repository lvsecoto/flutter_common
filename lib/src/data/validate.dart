/// 对数据验证，如果验证失败，则抛出错误
///
/// 把繁琐的代码
///
/// ```dart
/// if (name.isEmpty) {
///   throw '文本不能为空';
/// }
/// ```
///
/// 转换为:
/// ```dart
/// name.validateNotEmpty('文本不能为空');
/// ```
library common_validate;

import 'package:dartx/dartx.dart';

extension Validate on bool {
  void validate(dynamic error) {
    if(!this) {
      throw error;
    }
  }
}

extension StringValidate on String {

  /// 判断文本是否为空
  String validateNotEmpty(dynamic error) {
    (trim().isNotEmpty).validate(error);
    return trim();
  }

  /// 判断文本长度是否正确
  String validateLength(int length, dynamic error) {
    (trim().length == length).validate(error);
    return trim();
  }

  /// 验证文本是否能被转换为数字，并返回double，如果输入空，返回空
  ///
  /// 如果要确保输入是不为空的double，可以,
  /// ```dart
  /// '.validateDouble('请输入正确数字').validateNotEmpty('不能输入为空')',
  /// ```
  double? validateDouble(dynamic error) {
    if (isBlank) return null;
    final number = toDoubleOrNull();
    number.validateNotNull(error);
    return number;
  }

  /// 验证文本是否能被转换为数字，并返回int，如果输入空，返回空
  ///
  /// 如果要确保输入是不为空的int，可以,
  /// ```dart
  /// '.toIntOrNull('请输入正确数字').validateNotEmpty('不能输入为空')',
  /// ```
  int? validateInt(dynamic error) {
    if (isBlank) return null;
    final number = toIntOrNull();
    number.validateNotNull(error);
    return number;
  }
}

extension AnyValidate<T> on T? {

  /// 判断和[other]是否相等
  T validateEquals(T other, dynamic error) {
    (this == other).validate(error);
    return this!;
  }

  /// 判断是否为空
  T validateNotNull(dynamic error) {
    (this != null).validate(error);
    return this!;
  }
}

extension IterableValidate<I extends Iterable> on I? {

  /// 判断列表是否为空
  I validateNotEmpty(dynamic error) {
    (this?.isNotEmpty ?? false).validate(error);
    return this!;
  }
}

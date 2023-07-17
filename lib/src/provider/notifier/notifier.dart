/// 这里通过mixin给ProviderNotifier添加一些常用操作
library provider.notiifer;

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// ignore: implementation_imports
import 'package:riverpod/src/notifier.dart';

/// 给Notifier添加选择功能
mixin SelectableNotifier<T> on AutoDisposeNotifier<T> {
  /// 选择值
  void select(T value) {
    state = value;
  }

  /// 清除值
  void clear() {
    state = null as dynamic;
  }
}

/// 给Notifier增加开关功能
mixin ToggleableNotifier on AutoDisposeNotifier<bool> {
  /// 切换状态
  void toggle() {
    state = !state;
  }

  /// 打开状态
  void check() {
    state = true;
  }

  /// 关闭状态
  void unCheck() {
    state = false;
  }
}

mixin StreamValueNotifier<T> on AutoDisposeNotifier<T?> {
  /// 桥接Stream
  StreamSubscription? _subscription;

  @override
  T? build() {
    _subscription = buildStream().listen((next) {
      state = next;
      if (!_completer.isCompleted) {
        _completer.complete();
      }
    });
    ref.onDispose(() {
      _subscription?.cancel();
    });
    return null;
  }

  final _completer = Completer();

  /// 等待，直到第一个值出现
  Future<T?> get future async {
    await _completer.future;
    return state;
  }

  Stream<T?> buildStream();
}

/// 每当[changeNotifier]变化，会引起Notifier变化
///
/// 变化的值是从[select]获取到的
mixin ChangeNotifierNotifier<N extends ChangeNotifier, T> on AutoDisposeNotifier<T> {

  T select(N changeNotifier);

  @mustCallSuper
  T buildWith(N changeNotifier) {
    void onListener() {
      final value = select(changeNotifier);
      if (state != value) {
        onChange(value);
      }
    }

    changeNotifier.addListener(onListener);
    ref.onDispose(() {
      changeNotifier.removeListener(onListener);
    });
    return select(changeNotifier);
  }

  @mustCallSuper
  void onChange(T value) {
    state = value;
  }
}

/// 兼容[TextEditController]的notifier
///
/// ```dart
/// // 兼容@riverpod自动生成
/// @riverpod
/// class SomeTextEditNotifier extends _$SomeTextEditNotifier with TextEditNotifier {
///   @override
///   String build() {
///     return super.build();
///   }
/// }
///
/// // 在Widget使用
/// TextField(
///   controller: ref.watch(textEditNotifierProvider.notifier).controller,
/// )
///
/// // 可以在外部改变controller的值
/// ref.watch(textEditNotifierProvider.notifier).text = 'new text'
///
/// ```
mixin TextEditNotifier on AutoDisposeNotifier<String> {
  final _controller = TextEditingController();

  /// [controller]可以被TextField使用
  TextEditingController get controller => _controller;

  @mustBeOverridden
  @mustCallSuper
  @override
  String build() {
    void onChange() {
      if (_controller.text != state) {
        onTextChange();
      }
    }

    _controller.text = buildInitText();
    ref.onDispose(() {
      _controller.removeListener(onChange);
    });
    _controller.addListener(onChange);
    return _controller.text;
  }

  @mustCallSuper
  void onTextChange() {
    state = _controller.text;
  }

  /// 改变controller的值
  set text(String value) {
    _controller.text = value;
  }

  /// _controller的初始化文本，可以override
  String buildInitText() {
    return '';
  }
}

/// 焦点Notifier
mixin FocusNotifier on AutoDisposeNotifier<bool> {
  final _focusNode = FocusNode();

  @mustBeOverridden
  @mustCallSuper
  @override
  bool build() {
    _focusNode.addListener(onChange);
    ref.onDispose(() {
      _focusNode.removeListener(onChange);
    });
    return _focusNode.hasFocus;
  }

  void onChange() {
    state = _focusNode.hasFocus;
  }

  FocusNode get focusNode => _focusNode;

  /// 获取焦点
  void requestFocus() {
    focusNode.requestFocus();
  }

  /// 取消焦点
  void unfocus() {
    focusNode.unfocus();
  }
}

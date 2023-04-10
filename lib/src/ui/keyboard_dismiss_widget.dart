import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _KeyboardDismiss {
  /// 保存一些不需要自动关闭键盘的focusNode
  Set<FocusNode> ignore = {};
}

final _keyboardDismissProvider = Provider((ref) => _KeyboardDismiss());

class KeyboardAutoDismissWidget extends HookConsumerWidget {
  /// 包裹在App上面，如果碰到滑动，或者点击输入框外部，就收起键盘，并取消焦点
  ///
  /// 对于不想自动收起的[TextField]，可以用[useIgnoreKeyboardAutoDismissFocusNode]
  const KeyboardAutoDismissWidget({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollStartNotification) {
          if (notification.dragDetails != null) {
            _hideKeyboardIfNeed(ref);
          }
        }
        return false;
      },
      child: GestureDetector(
        onTap: () {
          _hideKeyboardIfNeed(ref);
        },
        child: child,
      ),
    );
  }

  /// 执行自动关闭键盘
  ///
  /// 这里会先判断这个focusNode是不是要忽略自动关闭键盘的
  void _hideKeyboardIfNeed(WidgetRef ref) {
    final currentFocus = FocusScope.of(ref.context);

    if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
      final keyBoardDismiss = ref.read(_keyboardDismissProvider);

      var primaryFocus = FocusManager.instance.primaryFocus;
      if (primaryFocus != null &&
          !keyBoardDismiss.ignore.contains(primaryFocus)) {
        primaryFocus.unfocus();
      }
    }
  }
}

/// 如果遇到不想自动关闭键盘的输入框之类的，可以给TextField传入这个focusNode
///
/// ```dart
/// TextField(
///   focusNode: useIgnoreKeyboardAutoDismissFocusNode(),
/// )
/// ```
/// (需要flutter_hook)
///
FocusNode useIgnoreKeyboardAutoDismissFocusNode({
  List<Object?>? keys,
}) {
  final context = useContext();
  final keyboardDismiss = useMemoized(
      () => ProviderScope.containerOf(context).read(_keyboardDismissProvider));
  final focusNode = useMemoized(() => FocusNode());
  useEffect(() {
    keyboardDismiss.ignore.add(focusNode);
    return () {
      keyboardDismiss.ignore.remove(focusNode);
    };
  }, [keyboardDismiss]);
  return focusNode;
}

import 'package:common/src/ui/keyboard_dismiss_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_portal/flutter_portal.dart';

class CommonAppWrapper extends StatelessWidget {
  /// 可以套在[MaterialApp]上，
  ///
  /// 引入常用的全局Widget:
  ///
  const CommonAppWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // river_pod依赖，虽然provider还是可以使用的，但以后将逐步迁徙到river_pod
    return ProviderScope(
      // Portal，可以实现popup类似的功能
      child: Portal(
        // 自动关闭键盘
        child: KeyboardAutoDismissWidget(
          child: child,
        ),
      ),
    );
  }
}

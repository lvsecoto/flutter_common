import 'package:flutter/material.dart';

class SafeAreaBottomWidget extends StatelessWidget {
  /// 一个高度为底部安全边距的空widget，方便和[Column]配合使用
  ///
  /// ```
  /// Column(
  ///   children: [
  ///     ///...others widget
  ///     const SafeAreaBottomWidget(),
  ///   ],
  /// )
  /// ```
  ///
  /// 另有Sliver版本的[SafeAreaSliverBottomWidget]
  const SafeAreaBottomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).viewPadding.bottom,
    );
  }
}

class SafeAreaSliverBottomWidget extends StatelessWidget {
  /// Sliver版本的[SafeAreaBottomWidget]，放在SliverList里面
  ///
  /// ```dart
  /// CustomScrollView(
  ///   slivers: [
  ///     const SafeAreaSliverBottomWidget(),
  ///   ],
  /// );
  /// ```
  const SafeAreaSliverBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: SafeAreaBottomWidget(),
    );
  }
}

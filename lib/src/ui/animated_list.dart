import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:flutter/material.dart';

class DiffSliverAnimatedList<T extends Object> extends StatelessWidget {
  static bool defaultAreItemsTheSame(dynamic oldItem, dynamic newItem) {
    return oldItem == newItem;
  }

  /// 用[areItemsTheSame]比较[items]的变化，实现列表条目动画效果
  const DiffSliverAnimatedList({
    super.key,
    required this.items,
    this.itemBuilder,
    this.indexedItemBuilder,
    this.areItemsTheSame = defaultAreItemsTheSame,
    this.keySelector,
  }) : assert(
          (itemBuilder != null && indexedItemBuilder == null) ||
              (indexedItemBuilder != null && itemBuilder == null),
          '二选其一',
        );

  final List<T> items;

  final bool Function(T oldItem, T newItem) areItemsTheSame;

  final Widget Function(BuildContext context, T item)? itemBuilder;

  final Widget Function(BuildContext context, T item, int index)?
      indexedItemBuilder;

  final Object Function(T item)? keySelector;

  @override
  Widget build(BuildContext context) {
    return SliverImplicitlyAnimatedList<T>(
      items: items,
      areItemsTheSame: areItemsTheSame,
      itemBuilder: (context, animation, item, index) => KeyedSubtree(
        key: ValueKey(keySelector?.call(item) ?? item),
        child: SizeFadeTransition(
          sizeFraction: 0.7,
          curve: Curves.easeInOut,
          animation: animation,
          child: itemBuilder != null
              ? itemBuilder!(context, item)
              : indexedItemBuilder!(context, item, index),
        ),
      ),
      // removeItemBuilder: (context, animation, oldItem) => FadeTransition(
      //   key: ValueKey(oldItem),
      //   opacity: animation,
      //   child: itemBuilder(context, oldItem),
      // ),
    );
  }
}

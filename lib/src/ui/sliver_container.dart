import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverContainer extends StatelessWidget {
  /// 给[child]加上边距颜色等，像Container一样使用
  const SliverContainer({
    super.key,
    required this.child,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.decoration,
    this.onTap,
    this.tapPadding,
    this.tapBorder,
  });

  final Widget child;

  /// 外边距，默认为0
  final EdgeInsets margin;

  /// 内边距，默认为0
  final EdgeInsets padding;

  /// 背景色等，和[Container]一样使用，默认没有
  final Decoration? decoration;

  /// 点击回调
  final VoidCallback? onTap;

  /// 点击区域的边界
  final EdgeInsets? tapPadding;

  /// 点击区域的边界
  final ShapeBorder? tapBorder;

  @override
  Widget build(BuildContext context) {
    var child = this.child;
    if (padding != EdgeInsets.zero) {
      child = SliverPadding(
        padding: padding,
        sliver: child,
      );
    }
    var decoration = this.decoration;
    if (decoration is BoxDecoration) {
      decoration = decoration.copyWith(
          boxShadow: decoration.boxShadow
              ?.map((it) => BoxShadow(
                    color: Theme.of(context).cardTheme.shadowColor!.withOpacity(
                          it.color.opacity *
                              Theme.of(context).cardTheme.shadowColor!.opacity,
                        ),
                    blurRadius: it.blurRadius,
                    blurStyle: it.blurStyle,
                    offset: it.offset,
                    spreadRadius: it.spreadRadius,
                  ))
              .toList());
    } else if (decoration is ShapeDecoration) {
      decoration = ShapeDecoration(
          shape: decoration.shape,
          color: decoration.color,
          gradient: decoration.gradient,
          image: decoration.image,
          shadows: decoration.shadows
              ?.map((it) => BoxShadow(
                    color: Theme.of(context).cardTheme.shadowColor!.withOpacity(
                          it.color.opacity *
                              Theme.of(context).cardTheme.shadowColor!.opacity,
                        ),
                    blurRadius: it.blurRadius,
                    blurStyle: it.blurStyle,
                    offset: it.offset,
                    spreadRadius: it.spreadRadius,
                  ))
              .toList());
    }
    Widget decoratedChild = SliverStack(
      children: [
        if (decoration != null)
          SliverPositioned.fill(
            child: Container(
              decoration: decoration,
            ),
          ),
        if (onTap != null)
          SliverPositioned.fill(
            left: tapPadding?.left ?? 0,
            top: tapPadding?.top ?? 0,
            right: tapPadding?.right ?? 0,
            bottom: tapPadding?.bottom ?? 0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                customBorder: tapBorder,
              ),
            ),
          ),
        child,
      ],
    );
    if (margin != EdgeInsets.zero) {
      decoratedChild = SliverPadding(padding: margin, sliver: decoratedChild);
    }
    return decoratedChild;
  }
}

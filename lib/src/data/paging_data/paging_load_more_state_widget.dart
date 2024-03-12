import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';

// ignore: implementation_imports
import 'package:riverpod/src/notifier.dart';

class PagingLoadMoreStateWidget<Notifier extends PagingLoadNotifierMixin>
    extends HookConsumerWidget {
  /// 放在列表底部，用来控制加载更多、显示加载更多状态
  const PagingLoadMoreStateWidget({
    super.key,
    required this.pagingLoadProvider,
  });

  /// 加载更多的[StateNotifier]
  // ignore: invalid_use_of_internal_member
  final NotifierProviderBase<Notifier, PagingLoadState> pagingLoadProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoadingMore =
        ref.watch(pagingLoadProvider.select((it) => it.isLoadingMore));
    final hasMore = ref.watch(pagingLoadProvider.select((it) => it.hasMore));
    final lastVisibleState = useRef(false);

    Widget child;
    if (hasMore) {
      child = AnimatedSizeAndFade(
        child: VisibilityDetector(
          key: Key(pagingLoadProvider.toString()),
          onVisibilityChanged: (it) {
            var visible = it.visibleFraction > 0.5;
            if (visible != lastVisibleState.value) {
              lastVisibleState.value = visible;
              if (visible) {
                Future.doWhile(() async {
                  await Future.delayed(const Duration(milliseconds: 250));
                  return (await ref
                          .read(pagingLoadProvider.notifier)
                          .loadMore() &&
                      lastVisibleState.value);
                });
              }
            }
          },
          child: AnimatedVisibilityWidget(
            animationWidgetBuilder:
                AnimatedVisibilityWidget.fadeAnimationWidgetBuilder,
            duration: kThemeAnimationDuration * 2,
            isVisible: isLoadingMore,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox.square(
                  dimension: 48,
                  child:
                      isLoadingMore ? const CircularProgressIndicator() : null,
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      child = const SizedBox.shrink();
    }

    return SliverToBoxAdapter(
      child: AnimatedSizeAndFade(
        childKey: (hasMore, pagingLoadProvider),
        child: child,
      ),
    );
  }
}

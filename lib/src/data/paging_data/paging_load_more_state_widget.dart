import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'paging_load_provider.dart';

class PagingLoadMoreStateWidget<Notifier extends PagingLoadNotifierMixin>
    extends ConsumerWidget {
  /// 放在列表底部，用来控制加载更多、显示加载更多状态
  const PagingLoadMoreStateWidget({
    super.key,
    required this.pagingLoadProvider,
  });

  /// 加载更多的[StateNotifier]
  final AutoDisposeNotifierProvider<Notifier, PagingLoadState>
      pagingLoadProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoadingMore =
        ref.watch(pagingLoadProvider.select((it) => it.isLoadingMore));
    final hasMore = ref.watch(pagingLoadProvider.select((it) => it.hasMore));

    Widget child;
    if (hasMore) {
      child = VisibilityDetector(
        key: Key(pagingLoadProvider.toString()),
        onVisibilityChanged: (it) {
          if(it.visibleFraction == 1.0) {
            ref.read(pagingLoadProvider.notifier).loadMore();
          }
        },
        child: AnimatedVisibilityWidget(
          animationWidgetBuilder: AnimatedVisibilityWidget.fadeAnimationWidgetBuilder,
          isVisible: isLoadingMore,
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox.square(
                dimension: 48,
                child: CircularProgressIndicator(),
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
        sizeDuration: kThemeAnimationDuration,
        fadeDuration: kThemeAnimationDuration,
        child: child,
      ),
    );
  }
}

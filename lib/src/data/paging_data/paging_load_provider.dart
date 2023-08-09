import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:synchronized/synchronized.dart';

import 'paging_data.dart';

part 'paging_load_provider.freezed.dart';

@freezed
class PagingLoadState<T> with _$PagingLoadState<T> {
  const PagingLoadState._();

  /// 分页加载状态
  const factory PagingLoadState({
    /// 当前加载到的所有数据
    required List<T> data,

    /// 是否还有更多数据
    @Default(false) bool hasMore,

    /// 是否在已经初始化完毕，也就是第一次加载完毕
    @Default(false) bool hasInitialized,

    /// 是否时[RefreshIndicator]引起的刷新，这个时候，不应显示加载图标，因为已经显示了
    @Default(false) bool isByRefreshIndicator,

    /// 是否在重新加载中
    @Default(false) bool isRefreshing,

    /// 是否在加载更多
    @Default(false) bool isLoadingMore,

    /// 最近一次重新加载失败错误
    Object? lastRefreshError,

    /// 最近一次重新加载失败错误
    StackTrace? lastRefreshErrorStacktrace,

    /// 最近一次加载失败错误
    Object? lastLoadingMoreError,
    StackTrace? lastLoadingMoreErrorStacktrace,
  }) = _PagingLoadState;

  bool get isLoading => isRefreshing || isLoadingMore;
}

/// {@template paging_data.PagingLoadNotifierMixin}
/// mixin到StateNotifier，让其有刷新、加载更多分页数据能力
///
/// ## 简介
///
/// 其中[PagingLoadNotifierMixin.fetch]需要实现
///
/// ## 使用方法
///
/// ### 重写build
/// {@macro paging_data.PagingLoadNotifierMixin.build}
///
/// ### `refresh`主动刷新数据
/// {@macro paging_data.PagingLoadNotifierMixin.refresh}
///
/// 推荐[PagingRefreshIndicator]刷新数据
///
/// ### `loadMore`加载更多数据
/// {@macro paging_data.PagingLoadNotifierMixin.loadMore}
///
/// 推荐[PagingLoadMoreStateWidget]加载更多
/// {@endtemplate}
mixin PagingLoadNotifierMixin<T, NextPageArg>
on AutoDisposeNotifier<PagingLoadState<T>> {
  NextPageArg? _nextPageArg;

  final _lock = Lock();

  PagingLoadState<T>? _state;

  @override
  set state(PagingLoadState<T> value) {
    _state = value;
    super.state = value;
  }

  /// {@template paging_data.PagingLoadNotifierMixin.build}
  ///
  /// * mixin重新写[AutoDisposeNotifier.build]来实现初始化操作，
  /// * 自动加载第一页数据
  /// * 我们可以在依赖发生了变化，重新加载数据，
  ///
  /// *由于依赖发生了变化，先前的数据会清除*
  ///
  /// *需要在StateNotifier中重写`build`，即使代码上是不需要的*
  /// 但因为riverpod生成器需要有个[build]才能生成代码
  /// ```dart
  /// @override
  /// PagingLoadState<Issue> build() {
  ///   // ignore: unnecessary_overrides
  ///   return super.build();
  /// }
  ///
  /// {@endtemplate}
  /// ```
  @override
  PagingLoadState<T> build() {
    _lock.synchronized(() async {
      _nextPageArg = null;
      await _fetchNextPage(
        onSuccess: (pagingData) {
          state = PagingLoadState(
            data: pagingData.data,
            hasMore: pagingData.hasMore,
            hasInitialized: true,
          );
        },
        onError: (error, stackTrace) {
          state = PagingLoadState(
            data: const [],
            lastRefreshError: error,
            lastRefreshErrorStacktrace: stackTrace,
            hasInitialized: true,
          );
        },
      );
    });
    return PagingLoadState(
      data: [],
      isRefreshing: true,
      hasInitialized: _state?.hasInitialized ?? false,
    );
  }

  /// {@template paging_data.PagingLoadNotifierMixin.refresh}
  /// 刷新整个列表，
  ///
  /// * 刷新时，*列表数据不会被清除*
  /// * 加载中的时候，重复调用没有效果
  /// * [Future]直到一页数据加载完才完成
  /// {@endtemplate}
  Future<void> refresh({bool isByRefreshIndicator = false}) async {
    if (state.isLoading) {
      return;
    }
    await _lock.synchronized(() async {
      _nextPageArg = null;
      state = state.copyWith(
        isRefreshing: true,
        isByRefreshIndicator: isByRefreshIndicator,
      );
      await _fetchNextPage(
        onSuccess: (pagingData) async {
          state = state.copyWith(
            data: [],
            hasMore: pagingData.hasMore,
          );
          // 先清除数据，再重新显示，500这个时间间隔是考虑到动画列表，消除条目需要500毫秒
          // 然后让列表回到0位置，如果不加这两行，刷新后列表会保持在原来的位置，不会回到0
          // 这样不符合效果
          await Future.delayed(const Duration(milliseconds: 500));
          state = state.copyWith(
            data: pagingData.data,
            isRefreshing: false,
          );
        },
        onError: (error, stackTrace) {
          state = state.copyWith(
            lastRefreshError: error,
            lastRefreshErrorStacktrace: stackTrace,
            isRefreshing: false,
          );
          debugPrint(error.toString());
          debugPrintStack(stackTrace: stackTrace);
        },
      );
    });
  }

  /// {@template paging_data.PagingLoadNotifierMixin.loadMore}
  /// 加载更多
  ///
  /// * 只有成功刷新后，且还有更多数据的时候，才能加载更多
  /// * 加载中的时候，重复调用没有效果
  /// * [Future]直到一页数据加载完才完成*
  /// {@endtemplate}
  Future<void> loadMore() async {
    if (state.isLoading) {
      return;
    }
    if (!state.hasMore) {
      return;
    }
    if (_nextPageArg == null) {
      // 只有第一页刷新成功后，_nextPageArg才不会为空
      return;
    }
    assert(state.lastRefreshError ==
        null, '_nextPageArg不为空，就不可能有刷新错误');
    await _lock.synchronized(() async {
      state = state.copyWith(isLoadingMore: true, hasMore: state.hasMore);
      await _fetchNextPage(
        onSuccess: (pagingData) {
          state = state.copyWith(
            data: [
              ...state.data,
              ...pagingData.data,
            ],
            hasMore: pagingData.hasMore,
            isLoadingMore: false,
          );
        },
        onError: (error, stackTrace) {
          state = state.copyWith(
            lastLoadingMoreError: error,
            lastLoadingMoreErrorStacktrace: stackTrace,
            isLoadingMore: false,
          );
          debugPrint(error.toString());
          debugPrintStack(stackTrace: stackTrace);
        },
      );
    });
  }

  /// {@template paging_data.PagingLoadNotifierMixin.fetch}
  /// 获取下一页数据，需要具体实现
  ///
  /// 参数为上一页加载的结果拿到的下一页参数
  /// * PagingData.nextPageArg
  ///
  /// 所以在加载第一页的时候，传入的[nextPageArg]为null
  /// {@endtemplate}
  Future<PagingData<NextPageArg, T>> fetch(NextPageArg? nextPageArg,);

  /// 加载下一页的数据，成功回调[onSuccess]，把结果传入；是比回调[onError]，把异常传入
  Future<void> _fetchNextPage({
    required FutureOr<void> Function(PagingData<NextPageArg, T> pagingData)
    onSuccess,
    required FutureOr<void> Function(Object? error, StackTrace stackTrace)
    onError,
  }) async {
    try {
      final pagingData = await fetch(_nextPageArg);
      _nextPageArg = pagingData.nextPageArg;
      await onSuccess(pagingData);
    } catch (e, stackTrace) {
      await onError(e, stackTrace);
    }
  }
}

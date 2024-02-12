// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paging_load_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PagingLoadState<T> {
  /// 当前加载到的所有数据
  List<T> get data => throw _privateConstructorUsedError;

  /// 是否还有更多数据
  bool get hasMore => throw _privateConstructorUsedError;

  /// 是否在已经初始化完毕，也就是第一次加载完毕
  bool get hasInitialized => throw _privateConstructorUsedError;

  /// 是否时[RefreshIndicator]引起的刷新，这个时候，不应显示加载图标，因为已经显示了
  bool get isByRefreshIndicator => throw _privateConstructorUsedError;

  /// 是否在重新加载中
  bool get isRefreshing => throw _privateConstructorUsedError;

  /// 是否在加载更多
  bool get isLoadingMore => throw _privateConstructorUsedError;

  /// 上一次加载到分页原始数据
  PagingData<dynamic, dynamic>? get lastPagingData =>
      throw _privateConstructorUsedError;

  /// 最近一次重新加载失败错误
  Object? get lastRefreshError => throw _privateConstructorUsedError;

  /// 最近一次重新加载失败错误
  StackTrace? get lastRefreshErrorStacktrace =>
      throw _privateConstructorUsedError;

  /// 最近一次加载失败错误
  Object? get lastLoadingMoreError => throw _privateConstructorUsedError;
  StackTrace? get lastLoadingMoreErrorStacktrace =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PagingLoadStateCopyWith<T, PagingLoadState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PagingLoadStateCopyWith<T, $Res> {
  factory $PagingLoadStateCopyWith(
          PagingLoadState<T> value, $Res Function(PagingLoadState<T>) then) =
      _$PagingLoadStateCopyWithImpl<T, $Res, PagingLoadState<T>>;
  @useResult
  $Res call(
      {List<T> data,
      bool hasMore,
      bool hasInitialized,
      bool isByRefreshIndicator,
      bool isRefreshing,
      bool isLoadingMore,
      PagingData<dynamic, dynamic>? lastPagingData,
      Object? lastRefreshError,
      StackTrace? lastRefreshErrorStacktrace,
      Object? lastLoadingMoreError,
      StackTrace? lastLoadingMoreErrorStacktrace});
}

/// @nodoc
class _$PagingLoadStateCopyWithImpl<T, $Res, $Val extends PagingLoadState<T>>
    implements $PagingLoadStateCopyWith<T, $Res> {
  _$PagingLoadStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? hasMore = null,
    Object? hasInitialized = null,
    Object? isByRefreshIndicator = null,
    Object? isRefreshing = null,
    Object? isLoadingMore = null,
    Object? lastPagingData = freezed,
    Object? lastRefreshError = freezed,
    Object? lastRefreshErrorStacktrace = freezed,
    Object? lastLoadingMoreError = freezed,
    Object? lastLoadingMoreErrorStacktrace = freezed,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasInitialized: null == hasInitialized
          ? _value.hasInitialized
          : hasInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      isByRefreshIndicator: null == isByRefreshIndicator
          ? _value.isByRefreshIndicator
          : isByRefreshIndicator // ignore: cast_nullable_to_non_nullable
              as bool,
      isRefreshing: null == isRefreshing
          ? _value.isRefreshing
          : isRefreshing // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      lastPagingData: freezed == lastPagingData
          ? _value.lastPagingData
          : lastPagingData // ignore: cast_nullable_to_non_nullable
              as PagingData<dynamic, dynamic>?,
      lastRefreshError: freezed == lastRefreshError
          ? _value.lastRefreshError
          : lastRefreshError,
      lastRefreshErrorStacktrace: freezed == lastRefreshErrorStacktrace
          ? _value.lastRefreshErrorStacktrace
          : lastRefreshErrorStacktrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
      lastLoadingMoreError: freezed == lastLoadingMoreError
          ? _value.lastLoadingMoreError
          : lastLoadingMoreError,
      lastLoadingMoreErrorStacktrace: freezed == lastLoadingMoreErrorStacktrace
          ? _value.lastLoadingMoreErrorStacktrace
          : lastLoadingMoreErrorStacktrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PagingLoadStateImplCopyWith<T, $Res>
    implements $PagingLoadStateCopyWith<T, $Res> {
  factory _$$PagingLoadStateImplCopyWith(_$PagingLoadStateImpl<T> value,
          $Res Function(_$PagingLoadStateImpl<T>) then) =
      __$$PagingLoadStateImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {List<T> data,
      bool hasMore,
      bool hasInitialized,
      bool isByRefreshIndicator,
      bool isRefreshing,
      bool isLoadingMore,
      PagingData<dynamic, dynamic>? lastPagingData,
      Object? lastRefreshError,
      StackTrace? lastRefreshErrorStacktrace,
      Object? lastLoadingMoreError,
      StackTrace? lastLoadingMoreErrorStacktrace});
}

/// @nodoc
class __$$PagingLoadStateImplCopyWithImpl<T, $Res>
    extends _$PagingLoadStateCopyWithImpl<T, $Res, _$PagingLoadStateImpl<T>>
    implements _$$PagingLoadStateImplCopyWith<T, $Res> {
  __$$PagingLoadStateImplCopyWithImpl(_$PagingLoadStateImpl<T> _value,
      $Res Function(_$PagingLoadStateImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? hasMore = null,
    Object? hasInitialized = null,
    Object? isByRefreshIndicator = null,
    Object? isRefreshing = null,
    Object? isLoadingMore = null,
    Object? lastPagingData = freezed,
    Object? lastRefreshError = freezed,
    Object? lastRefreshErrorStacktrace = freezed,
    Object? lastLoadingMoreError = freezed,
    Object? lastLoadingMoreErrorStacktrace = freezed,
  }) {
    return _then(_$PagingLoadStateImpl<T>(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasInitialized: null == hasInitialized
          ? _value.hasInitialized
          : hasInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      isByRefreshIndicator: null == isByRefreshIndicator
          ? _value.isByRefreshIndicator
          : isByRefreshIndicator // ignore: cast_nullable_to_non_nullable
              as bool,
      isRefreshing: null == isRefreshing
          ? _value.isRefreshing
          : isRefreshing // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      lastPagingData: freezed == lastPagingData
          ? _value.lastPagingData
          : lastPagingData // ignore: cast_nullable_to_non_nullable
              as PagingData<dynamic, dynamic>?,
      lastRefreshError: freezed == lastRefreshError
          ? _value.lastRefreshError
          : lastRefreshError,
      lastRefreshErrorStacktrace: freezed == lastRefreshErrorStacktrace
          ? _value.lastRefreshErrorStacktrace
          : lastRefreshErrorStacktrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
      lastLoadingMoreError: freezed == lastLoadingMoreError
          ? _value.lastLoadingMoreError
          : lastLoadingMoreError,
      lastLoadingMoreErrorStacktrace: freezed == lastLoadingMoreErrorStacktrace
          ? _value.lastLoadingMoreErrorStacktrace
          : lastLoadingMoreErrorStacktrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc

class _$PagingLoadStateImpl<T> extends _PagingLoadState<T>
    with DiagnosticableTreeMixin {
  const _$PagingLoadStateImpl(
      {required final List<T> data,
      this.hasMore = false,
      this.hasInitialized = false,
      this.isByRefreshIndicator = false,
      this.isRefreshing = false,
      this.isLoadingMore = false,
      this.lastPagingData,
      this.lastRefreshError,
      this.lastRefreshErrorStacktrace,
      this.lastLoadingMoreError,
      this.lastLoadingMoreErrorStacktrace})
      : _data = data,
        super._();

  /// 当前加载到的所有数据
  final List<T> _data;

  /// 当前加载到的所有数据
  @override
  List<T> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  /// 是否还有更多数据
  @override
  @JsonKey()
  final bool hasMore;

  /// 是否在已经初始化完毕，也就是第一次加载完毕
  @override
  @JsonKey()
  final bool hasInitialized;

  /// 是否时[RefreshIndicator]引起的刷新，这个时候，不应显示加载图标，因为已经显示了
  @override
  @JsonKey()
  final bool isByRefreshIndicator;

  /// 是否在重新加载中
  @override
  @JsonKey()
  final bool isRefreshing;

  /// 是否在加载更多
  @override
  @JsonKey()
  final bool isLoadingMore;

  /// 上一次加载到分页原始数据
  @override
  final PagingData<dynamic, dynamic>? lastPagingData;

  /// 最近一次重新加载失败错误
  @override
  final Object? lastRefreshError;

  /// 最近一次重新加载失败错误
  @override
  final StackTrace? lastRefreshErrorStacktrace;

  /// 最近一次加载失败错误
  @override
  final Object? lastLoadingMoreError;
  @override
  final StackTrace? lastLoadingMoreErrorStacktrace;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PagingLoadState<$T>(data: $data, hasMore: $hasMore, hasInitialized: $hasInitialized, isByRefreshIndicator: $isByRefreshIndicator, isRefreshing: $isRefreshing, isLoadingMore: $isLoadingMore, lastPagingData: $lastPagingData, lastRefreshError: $lastRefreshError, lastRefreshErrorStacktrace: $lastRefreshErrorStacktrace, lastLoadingMoreError: $lastLoadingMoreError, lastLoadingMoreErrorStacktrace: $lastLoadingMoreErrorStacktrace)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PagingLoadState<$T>'))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('hasMore', hasMore))
      ..add(DiagnosticsProperty('hasInitialized', hasInitialized))
      ..add(DiagnosticsProperty('isByRefreshIndicator', isByRefreshIndicator))
      ..add(DiagnosticsProperty('isRefreshing', isRefreshing))
      ..add(DiagnosticsProperty('isLoadingMore', isLoadingMore))
      ..add(DiagnosticsProperty('lastPagingData', lastPagingData))
      ..add(DiagnosticsProperty('lastRefreshError', lastRefreshError))
      ..add(DiagnosticsProperty(
          'lastRefreshErrorStacktrace', lastRefreshErrorStacktrace))
      ..add(DiagnosticsProperty('lastLoadingMoreError', lastLoadingMoreError))
      ..add(DiagnosticsProperty(
          'lastLoadingMoreErrorStacktrace', lastLoadingMoreErrorStacktrace));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PagingLoadStateImpl<T> &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.hasInitialized, hasInitialized) ||
                other.hasInitialized == hasInitialized) &&
            (identical(other.isByRefreshIndicator, isByRefreshIndicator) ||
                other.isByRefreshIndicator == isByRefreshIndicator) &&
            (identical(other.isRefreshing, isRefreshing) ||
                other.isRefreshing == isRefreshing) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.lastPagingData, lastPagingData) ||
                other.lastPagingData == lastPagingData) &&
            const DeepCollectionEquality()
                .equals(other.lastRefreshError, lastRefreshError) &&
            (identical(other.lastRefreshErrorStacktrace,
                    lastRefreshErrorStacktrace) ||
                other.lastRefreshErrorStacktrace ==
                    lastRefreshErrorStacktrace) &&
            const DeepCollectionEquality()
                .equals(other.lastLoadingMoreError, lastLoadingMoreError) &&
            (identical(other.lastLoadingMoreErrorStacktrace,
                    lastLoadingMoreErrorStacktrace) ||
                other.lastLoadingMoreErrorStacktrace ==
                    lastLoadingMoreErrorStacktrace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_data),
      hasMore,
      hasInitialized,
      isByRefreshIndicator,
      isRefreshing,
      isLoadingMore,
      lastPagingData,
      const DeepCollectionEquality().hash(lastRefreshError),
      lastRefreshErrorStacktrace,
      const DeepCollectionEquality().hash(lastLoadingMoreError),
      lastLoadingMoreErrorStacktrace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PagingLoadStateImplCopyWith<T, _$PagingLoadStateImpl<T>> get copyWith =>
      __$$PagingLoadStateImplCopyWithImpl<T, _$PagingLoadStateImpl<T>>(
          this, _$identity);
}

abstract class _PagingLoadState<T> extends PagingLoadState<T> {
  const factory _PagingLoadState(
          {required final List<T> data,
          final bool hasMore,
          final bool hasInitialized,
          final bool isByRefreshIndicator,
          final bool isRefreshing,
          final bool isLoadingMore,
          final PagingData<dynamic, dynamic>? lastPagingData,
          final Object? lastRefreshError,
          final StackTrace? lastRefreshErrorStacktrace,
          final Object? lastLoadingMoreError,
          final StackTrace? lastLoadingMoreErrorStacktrace}) =
      _$PagingLoadStateImpl<T>;
  const _PagingLoadState._() : super._();

  @override

  /// 当前加载到的所有数据
  List<T> get data;
  @override

  /// 是否还有更多数据
  bool get hasMore;
  @override

  /// 是否在已经初始化完毕，也就是第一次加载完毕
  bool get hasInitialized;
  @override

  /// 是否时[RefreshIndicator]引起的刷新，这个时候，不应显示加载图标，因为已经显示了
  bool get isByRefreshIndicator;
  @override

  /// 是否在重新加载中
  bool get isRefreshing;
  @override

  /// 是否在加载更多
  bool get isLoadingMore;
  @override

  /// 上一次加载到分页原始数据
  PagingData<dynamic, dynamic>? get lastPagingData;
  @override

  /// 最近一次重新加载失败错误
  Object? get lastRefreshError;
  @override

  /// 最近一次重新加载失败错误
  StackTrace? get lastRefreshErrorStacktrace;
  @override

  /// 最近一次加载失败错误
  Object? get lastLoadingMoreError;
  @override
  StackTrace? get lastLoadingMoreErrorStacktrace;
  @override
  @JsonKey(ignore: true)
  _$$PagingLoadStateImplCopyWith<T, _$PagingLoadStateImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

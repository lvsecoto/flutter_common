import 'dart:async';

import 'package:rxdart/rxdart.dart';

class RefreshStream<T> extends Stream<T> {
  final _controller = BehaviorSubject.seeded(null);

  final Stream<T> Function() streamFactory;

  /// 调用[refresh], [streamFactory]重新调用，重新订阅，实现刷新功能
  ///
  /// ``` dart
  /// final refreshStream = RefreshStream(() => Stream.fromIterable([1, 2, 3]));
  /// final sub = refreshStream.listen(print);
  /// await Future.delayed(const Duration(seconds: 3));
  /// // print 1,2,3
  ///
  /// refreshStream.refresh();
  /// await Future.delayed(const Duration(seconds: 3));
  /// // print 1,2,3
  ///
  /// await sub.cancel();
  /// ```
  ///
  RefreshStream(this.streamFactory);

  void refresh() {
    _controller.add(null);
  }

  @override
  StreamSubscription<T> listen(void Function(T event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return _controller.switchMap((_) => streamFactory()).listen(
          onData,
          onError: onError,
          onDone: onDone,
          cancelOnError: cancelOnError,
        );
  }
}

// ignore_for_file: implementation_imports

library flutter_echarts;

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'echarts_script.dart' show echartsScript;

/// <!DOCTYPE html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0, target-densitydpi=device-dpi" /><style type="text/css">body,html,#chart{height: 100%;width: 100%;margin: 0px;}div {-webkit-tap-highlight-color:rgba(255,255,255,0);}</style></head><body><div id="chart" /></body></html>
/// 'data:text/html;base64,' + base64Encode(const Utf8Encoder().convert( /* STRING ABOVE */ ))
const htmlBase64 =
    'data:text/html;base64,PCFET0NUWVBFIGh0bWw+PGh0bWw+PGhlYWQ+PG1ldGEgY2hhcnNldD0idXRmLTgiPjxtZXRhIG5hbWU9InZpZXdwb3J0IiBjb250ZW50PSJ3aWR0aD1kZXZpY2Utd2lkdGgsIGluaXRpYWwtc2NhbGU9MS4wLCBtYXhpbXVtLXNjYWxlPTEuMCwgbWluaW11bS1zY2FsZT0xLjAsIHVzZXItc2NhbGFibGU9MCwgdGFyZ2V0LWRlbnNpdHlkcGk9ZGV2aWNlLWRwaSIgLz48c3R5bGUgdHlwZT0idGV4dC9jc3MiPmJvZHksaHRtbCwjY2hhcnR7aGVpZ2h0OiAxMDAlO3dpZHRoOiAxMDAlO21hcmdpbjogMHB4O31kaXYgey13ZWJraXQtdGFwLWhpZ2hsaWdodC1jb2xvcjpyZ2JhKDI1NSwyNTUsMjU1LDApO308L3N0eWxlPjwvaGVhZD48Ym9keT48ZGl2IGlkPSJjaGFydCIgLz48L2JvZHk+PC9odG1sPg==';

class Echarts extends StatefulWidget {
  const Echarts(
      {Key? key,
      required this.option,
      this.extraScript = '',
      this.onMessage,
      this.extensions = const [],
      this.theme,
      this.captureAllGestures = false,
      this.captureHorizontalGestures = false,
      this.captureVerticalGestures = false,
      this.onLoad,
      this.onWebResourceError,
      this.reloadAfterInit = false})
      : super(key: key);

  final String option;

  final String extraScript;

  final void Function(String message)? onMessage;

  final List<String> extensions;

  final String? theme;

  final bool captureAllGestures;

  final bool captureHorizontalGestures;

  final bool captureVerticalGestures;

  final void Function(WebViewController)? onLoad;

  final void Function(WebViewController, Exception)? onWebResourceError;

  final bool reloadAfterInit;

  @override
  State<Echarts> createState() => _EchartsState();
}

class _EchartsState extends State<Echarts> {
  late WebViewController _controller;

  String? _currentOption;

  @override
  void initState() {
    super.initState();
    _currentOption = widget.option;

    _controller = WebViewController()
    ..loadRequest(Uri.parse(htmlBase64))
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.transparent)
    ..setNavigationDelegate(NavigationDelegate(
      onPageFinished: (url) {
        init();
      },
      onWebResourceError: (error) {
        widget.onWebResourceError?.call(_controller, Exception(error));
      },
    ));

    if (widget.reloadAfterInit) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _controller.reload();
      });
    }
  }

  void init() async {
    final extensionsStr = widget.extensions.isNotEmpty
        ? widget
            .extensions
            .reduce((value, element) => '$value\n$element')
        : '';
    final themeStr =
        widget.theme != null ? '\'${widget.theme}\'' : 'null';
    await _controller.runJavaScript('''
      $echartsScript
      $extensionsStr
      var chart = echarts.init(document.getElementById('chart'), $themeStr);
      ${widget.extraScript}
      chart.setOption($_currentOption, true);
    ''');
    if (widget.onLoad != null) {
      widget.onLoad!(_controller);
    }
  }

  Set<Factory<OneSequenceGestureRecognizer>> getGestureRecognizers() {
    Set<Factory<OneSequenceGestureRecognizer>> set = {};
    if (widget.captureAllGestures ||
        widget.captureHorizontalGestures) {
      set.add(Factory<HorizontalDragGestureRecognizer>(() {
        return HorizontalDragGestureRecognizer()
          ..onStart = (DragStartDetails details) {}
          ..onUpdate = (DragUpdateDetails details) {}
          ..onDown = (DragDownDetails details) {}
          ..onCancel = () {}
          ..onEnd = (DragEndDetails details) {};
      }));
    }
    if (widget.captureAllGestures || widget.captureVerticalGestures) {
      set.add(Factory<VerticalDragGestureRecognizer>(() {
        return VerticalDragGestureRecognizer()
          ..onStart = (DragStartDetails details) {}
          ..onUpdate = (DragUpdateDetails details) {}
          ..onDown = (DragDownDetails details) {}
          ..onCancel = () {}
          ..onEnd = (DragEndDetails details) {};
      }));
    }
    return set;
  }

  void update(String preOption) async {
    _currentOption = widget.option;
    if (_currentOption != preOption) {
      await _controller.runJavaScript('''
        try {
          chart.setOption($_currentOption, true);
        } catch(e) {
        }
      ''');
    }
  }

  @override
  void didUpdateWidget(Echarts oldWidget) {
    super.didUpdateWidget(oldWidget);
    update(oldWidget.option);
  }

  @override
  void dispose() {
    // _controller.clearCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: _controller,
        // javascriptChannels: <JavascriptChannel>{
        //   JavascriptChannel(
        //       name: 'Messager',
        //       onMessageReceived: (JavascriptMessage javascriptMessage) {
        //         if (widget.onMessage != null) {
        //           widget.onMessage!(javascriptMessage.message);
        //         }
        //       }),
        // },
        // gestureRecognizers: getGestureRecognizers()
    );
  }
}

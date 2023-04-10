import 'dart:async';

import 'package:flutter/material.dart';

import './widget.dart';

import 'child_node_list/child_node_list.dart';

class TreeNodeDialogWidget<T extends TreeNode> extends StatefulWidget {
  final Widget title;
  final T root;

  /// 返回true，就退出页面
  final FutureOr<bool> Function(TreePath<T> path)? onSelected;

  /// 显示树目录对话框界面，显示[root]的定义的目录
  const TreeNodeDialogWidget({
    Key? key,
    required this.title,
    required this.root,
    this.onSelected,
  }) : super(key: key);

  @override
  State<TreeNodeDialogWidget<T>> createState() => _TreeNodeDialogWidgetState<T>();
}

class _TreeNodeDialogWidgetState<T extends TreeNode>
    extends State<TreeNodeDialogWidget<T>> {
  TreePath<T> _path = [];
  late ScrollController _pathWidgetScrollController;

  @override
  void initState() {
    super.initState();
    _pathWidgetScrollController = ScrollController();
    _path.add(widget.root);
  }

  @override
  void dispose() {
    super.dispose();
    _pathWidgetScrollController.dispose();
  }

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Widget body;
    final Widget pathWidget;

    /// 顶部的面包屑组件
    pathWidget = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: IconTheme(
          data: theme.primaryIconTheme,
          child: DefaultTextStyle(
            style: theme.primaryTextTheme.labelMedium!,
            child: ListView.builder(
              controller: _pathWidgetScrollController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => _path[index].title(
                context,
                () {
                  setState(() {
                    // 点击按钮导航到特定位置
                    _path = _path.take(index + 1).toList();
                    _scrollToBottom();
                  });
                },
                null,
              ),
              itemCount: _path.length,
            ),
          ),
        ));

    /// 根据路径生成的导航页面
    final pages = _path
        .map(
          (node) => ChildNodeListPage<T>(
            node: node,
            path: _path,
            onNextNode: (childNode) async {
              if (childNode.childNodeProvider != null) {
                /// 如果子节点有子节点，就进入显示
                setState(() {
                  /// 点击条目调整到下一个
                  _path.add(childNode);
                  _scrollToBottom();
                });
              } else {
                /// 到达了叶子节点，交给外部处理
                final resultPath = _path.toList()..add(childNode);
                final onSelected = widget.onSelected;
                final navigator = Navigator.of(context);
                if (onSelected == null) {
                  navigator.pop(resultPath);
                } else {
                  final shouldPop = await onSelected(resultPath);
                  if (shouldPop) {
                    navigator.pop(resultPath);
                  }
                }
              }
            },
          ),
        )
        .toList();

    body = Navigator(
      key: navigatorKey,
      onPopPage: (route, result) {
        setState(() {
          /// 返回上一个页面
          _path.removeLast();
          _scrollToBottom();
        });
        return route.didPop(result);
      },
      pages: pages,
    );

    return WillPopScope(
      onWillPop: () async {
        var navigator = navigatorKey.currentState!;
        if (navigator.canPop()) {
          navigator.pop();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: widget.title,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(32),
            child: SizedBox(
              height: 32,
              child: pathWidget,
            ),
          ),
        ),
        body: body,
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _pathWidgetScrollController.animateTo(
          _pathWidgetScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn);
    });
  }
}

class ChildNodeListPage<T extends TreeNode> extends Page<T> {
  /// 当前节点
  final T node;

  /// 节点[node]所在的路径
  final TreePath<T> path;

  /// 当进入下一个节点时
  final Function(T next) onNextNode;

  /// BreadCrumb下的下一个条目
  ChildNodeListPage({
    required this.node,
    required this.path,
    required this.onNextNode,
  }) : super(key: ValueKey(node));

  @override
  Route<T> createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => ChildNodeListPageWidget<T>(
        childNode: node.childNodeProvider!,
        path: path,
        onNextNode: onNextNode,
      ),
    );
  }
}

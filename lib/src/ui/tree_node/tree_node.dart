import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'widget/widget.dart';

export 'common.dart';
export 'widget/tree_node_dialog_widget.dart';

/// 显示一个由[TreeNode]组成的，类似文件浏览器，带面包屑导航的对话框
///
/// 结果返回[TreePath]
/// see [MapTreeNode] : [TreeNode]Map的实现
/// see [TreeNodeDialogWidget] 可以作为一个页面去处理
Future<TreePath<T>?> showTreeNodeDialog<T extends TreeNode>(
  BuildContext context, {
  required T root,

  /// 标题
  required Widget title,

  /// 选择了叶子节点，
  /// 返回true，页面关闭，否则继续
  Future<bool> Function(TreePath<T> path)? onSelected,
  bool fullscreenDialog = false,
}) =>
    Navigator.of(context).push<TreePath<T>>(MaterialPageRoute(
      builder: (context) => TreeNodeDialogWidget<T>(
        title: title,
        root: root,
        onSelected: onSelected,
      ),
      fullscreenDialog: fullscreenDialog,
    ));

/// 路径，路径一个片段就是节点，会作为[showTreeNodeDialog]结果返回
typedef TreePath<T extends TreeNode> = List<T>;

extension TreePathEx<T extends TreeNode> on TreePath<T> {
  /// 从路径获取当前节点
  T get current => last;
}

class ChildNodeProvider<T extends TreeNode> {
  /// 负责从节点拉取子节点
  ChildNodeProvider(this.fetch);

  /// 返回子节点
  final Future<List<T>> Function(TreePath<T> path) fetch;

  /// 当前的子节点
  final _childNodes = BehaviorSubject<List<T>>.seeded([]);

  /// 供观察子节点
  Stream<List<T>> get childNodes => _childNodes.stream.asBroadcastStream();

  /// 是否正在加载中
  Stream<bool> get isLoading => _isLoading.stream.asBroadcastStream();
  final _isLoading = BehaviorSubject.seeded(false);

  /// 最后一次加载时的错误
  Stream<dynamic> get lastError => _lastError.stream.asBroadcastStream();
  final _lastError = BehaviorSubject<dynamic>.seeded(null);

  /// 是否已经初始化过了
  /// 一般页面会初始化一次，然后由用户手动刷新[refresh]
  var _hasInit = false;

  /// 初始化，没加载才会去加载
  void init(TreePath<T> path) {
    if (!_hasInit && !_isLoading.value) {
      _hasInit = true;
      _fetch(path);
    }
  }

  /// 强制刷新，除非正在加载，都不会刷新
  Future<void> refresh(TreePath<T> path) async {
    if (!_isLoading.value) {
      await _fetch(path);
    }
  }

  Future<void> _fetch(TreePath<T> path) async {
    _lastError.value = null;
    _isLoading.value = true;
    late List<T> value;
    try {
      value = await fetch(path);
    } catch (e, stackTrace) {
      _lastError.value = e;
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      _isLoading.value = false;
      _childNodes.value = value;
    }
  }
}

/// 一个节点
/// 比如文件管理器列表中的文件，文件夹
/// 文件路径也是由节点组成的
abstract class TreeNode {
  const TreeNode();

  /// 获取下一个列表
  ChildNodeProvider<TreeNode>? get childNodeProvider;

  bool get hasChildNode => childNodeProvider != null;

  ValueWidgetBuilder<VoidCallback> get tile;

  ValueWidgetBuilder<VoidCallback> get title;
}

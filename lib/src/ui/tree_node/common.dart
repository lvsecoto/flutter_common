import 'dart:async';

import 'package:flutter/material.dart';

import 'tree_node.dart';

/// 从一个Map创建TreeNode
class MapTreeNode extends TreeNode {
  MapTreeNode(
    this.key,
    this.child, {
    this.value,
    bool? isRoot,
    this.getTitle,
  }) : isRoot = isRoot ?? false;

  /// 用一个Map创建，要求每一个值要不是null（代表叶子节点），要不是不为空的Map
  MapTreeNode.root({required String rootName, this.child})
      : key = rootName,
        value = null,
        isRoot = true;

  /// 当前节点的key
  final String key;

  /// 后面的子节点Map
  final FutureOr<Map<String, dynamic>>? child;

  /// 是否是根节点
  final bool isRoot;

  /// 如果是叶节点，这个值就是叶子节点的Value
  final String? value;

  /// 通过key获取标题
  String Function(String key)? getTitle;

  @override
  ChildNodeProvider? get childNodeProvider {
    final child = this.child;
    if (child == null) {
      return null;
    }
    return _childNodeProvider ??=
        ChildNodeProvider((path) async => (await child).entries.map((it) {
              final childeNode = it.value;
              if (childeNode is Map<String, dynamic>) {
                // 子还有子节点
                return MapTreeNode(it.key, childeNode);
              } else if (childeNode == null || childeNode is String) {
                // 这级是叶子结点
                return MapTreeNode(it.key, null, value: childeNode);
              } else {
                throw '输入Map<String, dynamic> map，value只能是Map<String, dynamic>或者是String?';
              }
            }).toList());
  }

  ChildNodeProvider? _childNodeProvider;

  @override
  ValueWidgetBuilder<VoidCallback> get tile => (context, onTap, _) => ListTile(
        title: Text(_getTitle(key)),
        onTap: onTap,
      );

  @override
  ValueWidgetBuilder<VoidCallback> get title => (context, onTap, _) => isRoot
      ? TreePathRootItemWidget(title: _getTitle(key), onTap: onTap)
      : TreePathItemWidget(title: _getTitle(key), onTap: onTap);

  String _getTitle(String key) {
    final getTitle = this.getTitle;
    if (getTitle == null) return key;
    return getTitle(key);
  }
}

class TreePathRootItemWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  /// 面包屑导航根条目，没有箭头
  const TreePathRootItemWidget({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: onTap,
          customBorder: const StadiumBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(title),
          ),
        ),
      ],
    );
  }
}

class TreePathItemWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  /// 面包屑导航条目
  const TreePathItemWidget({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.chevron_right),
        InkWell(
          onTap: onTap,
          customBorder: const StadiumBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(title),
          ),
        ),
      ],
    );
  }
}

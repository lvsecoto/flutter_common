import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../tree_node.dart';

import 'child_node_list_error_widget.dart';
import 'child_node_list_loading_widget.dart';
import 'child_node_list_widget.dart';

class ChildNodeListPageWidget<T extends TreeNode> extends HookWidget {
  /// 一个子页面，包括了列表，已经加载中，加载失败的显示。
  ///
  /// 该列表显示该节点[childNode]下的子节点，
  ChildNodeListPageWidget({
    required this.childNode,
    required this.path,
    required this.onNextNode,
  }) : super(key: ValueKey(childNode));

  /// 当前节点
  final ChildNodeProvider childNode;

  /// 这节点[childNode]所在的路径
  final TreePath<T> path;

  /// 当进入下一个节点
  final Function(T childNode) onNextNode;

  @override
  Widget build(BuildContext context) {
    useMemoized(() {
      childNode.init(path);
    });

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ChildNodeListWidget<T>(childNode: childNode, onNextNode: onNextNode),
          Center(child: ChildNodeLoadingWidget(childNode: childNode)),
          Positioned.fill(
            bottom: null,
            child: ChildNodeListErrorWidget(childNode: childNode),
          ),
        ],
      ),
    );
  }
}

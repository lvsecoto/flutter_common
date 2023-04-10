import 'package:flutter/material.dart';
import '../../tree_node.dart';

class ChildNodeListWidget<T extends TreeNode> extends StatelessWidget {
  /// 显示子节点列表，已经加载状体信息
  const ChildNodeListWidget({
    Key? key,
    required this.childNode,
    required this.onNextNode,
  }) : super(key: key);

  final ChildNodeProvider childNode;
  final Function(T node) onNextNode;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TreeNode>>(
      stream: childNode.childNodes,
      builder: (context, snapshot) {
        final childNodes = snapshot.data ?? [];
        return ListView.builder(
          itemBuilder: (context, index) => childNodes[index].tile(
            context,
            () {
              final childNode = childNodes[index];
              onNextNode(childNode as T);
            },
            null,
          ),
          itemCount: childNodes.length,
        );
      },
    );
  }
}

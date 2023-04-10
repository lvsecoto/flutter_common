import 'package:flutter/material.dart';
import '../../../animated_visibility_widget.dart';
import '../../tree_node.dart';

class ChildNodeListErrorWidget extends StatelessWidget {
  /// 显示为一个子Node列表加载错误的Widget
  const ChildNodeListErrorWidget({
    Key? key,
    required this.childNode,
  }) : super(key: key);

  final ChildNodeProvider childNode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return StreamBuilder<dynamic>(
      stream: childNode.lastError,
      builder: (context, snapshot) {
        final lastError = snapshot.data;
        return AnimatedVisibilityWidget(
          isVisible: lastError != null,
          animationWidgetBuilder:
              AnimatedVisibilityWidget.verticalAnimationWidgetBuilder,
          child: SizedBox(
            width: double.infinity,
            child: ListTile(
              title: Builder(
                builder: (context) => Text(
                  lastError.toString(),
                  style: DefaultTextStyle.of(context).style.copyWith(
                        color: theme.colorScheme.onError,
                      ),
                ),
              ),
              tileColor: theme.colorScheme.error,
            ),
          ),
        );
      },
    );
  }
}

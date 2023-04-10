import 'package:flutter/material.dart';
import '../../../animated_visibility_widget.dart';
import '../../tree_node.dart';

class ChildNodeLoadingWidget extends StatelessWidget {
  /// 显示为一个子Node列表加载中的Widget
  const ChildNodeLoadingWidget({
    Key? key,
    required this.childNode,
  }) : super(key: key);

  final ChildNodeProvider childNode;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: childNode.isLoading,
      builder: (context, snapshot) {
        final isLoading = snapshot.data ?? false;
        return AnimatedVisibilityWidget(
          isVisible: isLoading,
          animationWidgetBuilder:
              AnimatedVisibilityWidget.fadeAnimationWidgetBuilder,
          child: const Padding(
            padding: EdgeInsets.only(top: 32),
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

import 'dart:io';

import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:photo_view/photo_view.dart';
import 'package:saver_gallery/saver_gallery.dart';

typedef OnImageViewerMessage = Function(BuildContext context, String message);

/// 权限缺失提示
typedef OnImageViewerRequestPermission = void Function(BuildContext context);

/// 打开图片查看器
void showImageViewer(
  BuildContext context, {
  /// 用来渲染图片
  required ImageProvider imageProvider,

  /// 是否可以保存图片
  bool canSave = false,

  /// 图片标题
  String? title,

  /// 每当要显示消息的时候回调
  required OnImageViewerMessage onImageViewerMessage,

  /// 每当需要显示提示缺失权限的时候回调
  required OnImageViewerRequestPermission onImageViewerRequestPermission,
}) {
  Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
    builder: (context) => _ImageViewerWidget(
      imageProvider: imageProvider,
      canSave: canSave,
      title: title,
      onImageViewerMessage: onImageViewerMessage,
      onImageViewerRequestPermission: onImageViewerRequestPermission,
    ),
    fullscreenDialog: true,
  ));
}

class _ImageViewerWidget extends StatelessWidget {
  const _ImageViewerWidget({
    required this.imageProvider,
    this.canSave = false,
    this.title,
    required this.onImageViewerMessage,
    required this.onImageViewerRequestPermission,
  });

  final ImageProvider imageProvider;

  final String? title;

  final bool canSave;

  final OnImageViewerMessage onImageViewerMessage;

  final OnImageViewerRequestPermission onImageViewerRequestPermission;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(
          double.maxFinite,
          kToolbarHeight,
        ),
        child: ShadowWidget(
          opacity: 0.84,
          offset: Offset.zero,
          sigma: 4,
          child: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
            ),
            foregroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            title: title == null ? null : Text(title!),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              if (canSave)
                IconButton(
                  onPressed: () async {
                    final imageProvider = this.imageProvider;
                    if (imageProvider is MemoryImage) {
                      final result = await SaverGallery.saveImage(
                        imageProvider.bytes,
                        quality: 100,
                        name: title ??
                            DateTime.now().millisecondsSinceEpoch.toString(),
                        androidExistNotSave: true,
                      );

                      if (result.isSuccess && context.mounted) {
                        onImageViewerMessage(context, '图片已保存到相册');
                      } else if (!result.isSuccess &&
                          Platform.isIOS &&
                          context.mounted) {
                        onImageViewerRequestPermission(context);
                      } else if (!result.isSuccess && context.mounted) {
                        onImageViewerMessage(context, '保存失败');
                      }
                    }
                  },
                  icon: const Icon(Icons.save),
                ),
            ],
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: PhotoView(
        imageProvider: imageProvider,
        onTapDown: (_, __, ___) {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

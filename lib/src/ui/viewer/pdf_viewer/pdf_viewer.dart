import 'package:common/common.dart';
import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

/// 根据[pdfData]显示PDF浏览器，标题是[title]，还能把PDF保存到本地，也可以通过[canSave]禁止保存
Future<void> showPdfViewer(
  BuildContext context, {
  /// PDF标题
  String? title,

  /// PDF数据
  required Uint8List pdfData,

  /// 是否可以把PDF下载下来
  bool canSave = false,

  /// 每当要提示消息的时候回调
  required void Function(BuildContext context, String message) onMessage,
}) async {
  await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Scaffold(
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
                  title: Text(title ?? 'PDF预览'),
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.dark,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    IconButton(
                      onPressed: () async {
                        var fileName = title;
                        if (fileName != null) {
                          if (!(fileName.toLowerCase()).endsWith('.pdf')) {
                            fileName = '$fileName.pdf';
                          }
                        } else {
                          fileName =
                              '${DateTime.now().millisecondsSinceEpoch.toString()}.pdf';
                        }
                        await DocumentFileSavePlus().saveFile(
                          pdfData,
                          fileName,
                          "application/pdf",
                        );
                        if (context.mounted) {
                          onMessage(context, '保存PDF成功');
                        }
                      },
                      icon: const Icon(Icons.save),
                    ),
                  ],
                ),
              ),
            ),
            extendBodyBehindAppBar: true,
            body: SfPdfViewerTheme(
              data: SfPdfViewerThemeData(
                backgroundColor: Colors.black,
              ),
              child: SfPdfViewer.memory(
                pdfData,
              ),
            ),
          )));
}

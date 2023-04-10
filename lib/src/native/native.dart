import 'package:url_launcher/url_launcher.dart';

/// 打电话[phone]
Future<void> dail(String phone) async {
  launchUrl(Uri.parse('tel:$phone'));
}

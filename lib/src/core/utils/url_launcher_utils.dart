import 'package:getx_clean_architecture_boilerplate/src/core/utils/toast_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {
  static Future<void> openUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      ToastUtils.showErrorToast(
        message: 'Could not launch $url',
      );
    }
  }
}

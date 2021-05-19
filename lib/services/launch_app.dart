import 'package:url_launcher/url_launcher.dart';

class LaunchApp {
  Future<void> launchInBrowser(String url) async {
    if (!url.contains("http") &&
        !url.contains("mailto") &&
        !url.contains("tel")) url = "http://" + url;
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}

import 'package:url_launcher/url_launcher.dart';

class LaunchURL {
  Future openURL(String url) async {
    Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}

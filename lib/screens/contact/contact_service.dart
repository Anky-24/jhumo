import 'package:url_launcher/url_launcher.dart';

Future<void> launchMail(String mail) async {
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: mail,
    query: encodeQueryParameters(
        <String, String>{'subject': 'Want to advertise on Jhumo Radio'}),
  );

  launchUrl(emailLaunchUri);
}

Future<void> makePhoneCall(String number) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: "+91$number",
  );
  await launchUrl(launchUri);
}

Future<void> launchInBrowser(String site) async {
  Uri url = Uri(scheme: 'https', host: site);
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}

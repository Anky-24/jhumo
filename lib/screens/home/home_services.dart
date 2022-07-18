import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jhumo/utils/utils.dart';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> share(BuildContext context) async {
  ByteData imagebyte = await rootBundle.load(logo);
  final temp = await getTemporaryDirectory();
  final path = '${temp.path}/logo.jpg';
  File(path).writeAsBytesSync(imagebyte.buffer.asUint8List());
  ShareResult res = await Share.shareFilesWithResult([path], text: shareMsg);
  if (res.status != ShareResultStatus.success) {
    SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
      dismissDirection: DismissDirection.horizontal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: const Color(0x90000000),
      content: Text(
        noShareSnackBar,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.w500,
            ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

Future<void> launchWhatsapp(String number) async {
  final Uri url = Uri.parse("whatsapp://send?phone=$number");

  if (!await launchUrl(url)) throw 'Could not launch $url';
}

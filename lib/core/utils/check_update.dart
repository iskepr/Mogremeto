import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:package_info_plus/package_info_plus.dart";
import "package:url_launcher/url_launcher.dart";

import "../../constants.dart";

Future<void> checkForUpdate(BuildContext context) async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final String currentVersion = packageInfo.version;

  final response = await http.get(Uri.parse(kAppLink));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final String latestVersion = data["tag_name"].replaceFirst("v", "");
    final String downloadUrl = data["assets"][0]["browser_download_url"];

    // قارن رقم الإصدار
    if (_isNewVersionAvailable(currentVersion, latestVersion) &&
        context.mounted) {
      _showUpdateDialog(
        context,
        downloadUrl,
        currentVersion: currentVersion,
        newVersion: latestVersion,
      );
    }
  }
}

bool _isNewVersionAvailable(String current, String latest) {
  final List<int> currentParts = current.split(".").map(int.parse).toList();
  final List<int> latestParts = latest.split(".").map(int.parse).toList();
  for (int i = 0; i < latestParts.length; i++) {
    if (latestParts[i] > currentParts[i]) {
      return true;
    } else if (latestParts[i] < currentParts[i]) {
      return false;
    }
  }
  return false;
}

void _showUpdateDialog(
  BuildContext context,
  String downloadUrl, {
  String currentVersion = "",
  String newVersion = "",
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFFFFF0CC),
      title: const Text(
        "!تحديث جديد متاح",
        textAlign: TextAlign.right,
        style: TextStyle(color: Color(0xFF822222)),
      ),
      content: Text(
        ".يفضل تحديث اللعبة عشان احدث المميزات $currentVersion ~> $newVersion",
        textAlign: TextAlign.right,
        style: const TextStyle(color: Color(0xFF822222)),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "لاحقًا",
            style: TextStyle(color: Color(0xFF822222)),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (await canLaunch(downloadUrl)) {
              await launch(downloadUrl);
            }
          },
          child: const Text(
            "تحديث الآن",
            style: TextStyle(color: Color(0xFF822222)),
          ),
        ),
      ],
    ),
  );
}

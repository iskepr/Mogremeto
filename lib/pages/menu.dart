import 'dart:convert';

import 'package:startapp_sdk/startapp.dart';

import '../pages/Game/addPlayers.dart';
import '../pages/issues.dart';
import '../widgets/button.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mogremeto/data/stories.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  // ----- الاعلان
  var startAppSdk = StartAppSdk();

  StartAppBannerAd? bannerAd;

  @override
  void initState() {
    super.initState();
    getStories();
    checkForUpdate();
    startAppSdk.setTestAdsEnabled(true);

    startAppSdk
        .loadBannerAd(StartAppBannerType.BANNER)
        .then((bannerAd) {
          setState(() {
            this.bannerAd = bannerAd;
          });
        })
        .onError<StartAppException>((ex, stackTrace) {
          debugPrint("مش لاقيييييييييييييييي الاعلاااان واحددد: ${ex.message}");
        })
        .onError((error, stackTrace) {
          debugPrint("مش لاقيييييييييييييييي الاعلاااان اتنييننننن: $error");
        });
  }

  // ----- تحديث القصص
  Future<void> getStories() async {
    final localStories = Stories().stories;
    final response = await http.get(
      Uri.parse(
        'https://raw.githubusercontent.com/iskepr/Mogremeto/main/stories.json',
      ),
    );
    List stories;
    if (response.statusCode != 200) {
      stories = localStories;
      print("⚠️ فشل في تحميل البيانات من السرفر!");
    } else {
      stories = json.decode(response.body);
    }

    final prefs = await SharedPreferences.getInstance();

    for (var story in stories) {
      if (story == null) {
        print("⚠️ القصة غير موجودة داخل كائن story!");
        continue;
      }
      final storyId = story['id'];
      if (storyId == null) {
        print("⚠️ القصة مفقود فيها ID أو Story!");
        continue;
      }

      bool alreadyExists = localStories.any((s) => s['id'] == storyId);

      if (!alreadyExists) {
        localStories.add({
          'id': storyId,
          'story': story['story'],
          'title': story['title'],
          'type': story['type'],
          'evidence': story['evidence'],
          'accused': story['accused'],
        });
      }
    }

    await prefs.setString('localStories', jsonEncode(localStories));
  }

  // ----- تحديث التطبيق
  Future<void> checkForUpdate() async {
    // احصل على رقم إصدار التطبيق الحالي
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;

    // احصل على آخر إصدار من GitHub
    final response = await http.get(
      Uri.parse(
        'https://api.github.com/repos/iskepr/mogremeto/releases/latest',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      String latestVersion = data['tag_name'].replaceFirst('v', '');
      String downloadUrl = data['assets'][0]['browser_download_url'];

      // قارن رقم الإصدار
      if (_isNewVersionAvailable(currentVersion, latestVersion)) {
        _showUpdateDialog(downloadUrl);
      }
    }
  }

  bool _isNewVersionAvailable(String current, String latest) {
    List<int> currentParts = current.split('.').map(int.parse).toList();
    List<int> latestParts = latest.split('.').map(int.parse).toList();
    for (int i = 0; i < latestParts.length; i++) {
      if (latestParts[i] > currentParts[i]) {
        return true;
      } else if (latestParts[i] < currentParts[i]) {
        return false;
      }
    }
    return false;
  }

  void _showUpdateDialog(String downloadUrl) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFFFFF0CC),
        title: Text(
          "!تحديث جديد متاح",
          textAlign: TextAlign.right,
          style: TextStyle(color: Color(0xFF822222)),
        ),
        content: Text(
          ".يفضل تحديث اللعبة عشان احدث المميزات",
          textAlign: TextAlign.right,
          style: TextStyle(color: Color(0xFF822222)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("لاحقًا", style: TextStyle(color: Color(0xFF822222))),
          ),
          TextButton(
            onPressed: () async {
              if (await canLaunch(downloadUrl)) {
                await launch(downloadUrl);
              }
            },
            child: Text(
              "تحديث الآن",
              style: TextStyle(color: Color(0xFF822222)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0CC),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: 30,
              left: 10,
              child: SvgPicture.asset('assets/imgs/cornerTL.svg', width: 150),
            ),
            Positioned(
              bottom: 40,
              right: 10,
              child: SvgPicture.asset('assets/imgs/cornerBR.svg', width: 150),
            ),
            Center(
              child: Column(
                children: [
                  Expanded(
                    child: SvgPicture.asset('assets/imgs/logo.svg', width: 250),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          Button(
                            title: 'قضية جديدة',
                            onTap: () async {
                              if (kIsWeb) {
                                await AudioPlayer().play(
                                  UrlSource('assets/sounds/click.mp3'),
                                );
                              } else {
                                await AudioPlayer().play(
                                  AssetSource('sounds/click.mp3'),
                                );
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddPlayers(),
                                ),
                              );
                            },
                          ),
                          Button(
                            title: 'القضايا',
                            onTap: () async {
                              if (kIsWeb) {
                                await AudioPlayer().play(
                                  UrlSource('assets/sounds/click.mp3'),
                                );
                              } else {
                                await AudioPlayer().play(
                                  AssetSource('sounds/click.mp3'),
                                );
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Issues(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await launch('https://iskepr.github.io');
                    },
                    child: Column(
                      children: const [
                        Text(
                          'برمجة',
                          style: TextStyle(
                            color: Color(0xFF228272),
                            fontSize: 20,
                            letterSpacing: -1,
                          ),
                        ),
                        Text(
                          'سكيبر',
                          style: TextStyle(
                            color: Color(0xFF822222),
                            fontSize: 30,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
            Positioned(
              bottom: -20,
              right: 30,
              child: Expanded(
                child: bannerAd != null
                    ? StartAppBanner(bannerAd!)
                    : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

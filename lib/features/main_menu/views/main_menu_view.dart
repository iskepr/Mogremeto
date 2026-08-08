import "dart:convert";

import "package:audioplayers/audioplayers.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:http/http.dart" as http;
import "package:shared_preferences/shared_preferences.dart";
import "package:url_launcher/url_launcher.dart";

import "../../../constants.dart";
import "../../../core/utils/check_update.dart";
import "../../../core/widgets/button.dart";
import "../../issues/views/issues_view.dart";
import "../../roleplay/views/add_players.dart";

class MainMenuView extends StatefulWidget {
  const MainMenuView({super.key});

  @override
  State<MainMenuView> createState() => _MainMenuViewState();
}

class _MainMenuViewState extends State<MainMenuView> {
  @override
  void initState() {
    super.initState();
    getStories();
    checkForUpdate(context);
  }

  // ----- تحديث القصص
  Future<void> getStories() async {
    final List localStories = jsonDecode(
      await rootBundle.loadString(kRoleplayStoriesPath),
    );
    final response = await http.get(Uri.parse(kApi));
    List stories;
    if (response.statusCode != 200) {
      stories = localStories;
      debugPrint("فشل في تحميل البيانات من السرفر!");
    } else {
      stories = json.decode(response.body);
    }

    final prefs = await SharedPreferences.getInstance();

    for (var story in stories) {
      if (story == null) {
        debugPrint("القصة غير موجودة داخل كائن story!");
        continue;
      }
      final storyId = story["id"];
      if (storyId == null) {
        debugPrint("القصة مفقود فيها ID أو Story!");
        continue;
      }

      final bool alreadyExists = localStories.any((s) => s["id"] == storyId);

      if (!alreadyExists) {
        localStories.add({
          "id": storyId,
          "story": story["story"],
          "title": story["title"],
          "type": story["type"],
          "evidence": story["evidence"],
          "accused": story["accused"],
        });
      }
    }

    await prefs.setString("localStories", jsonEncode(localStories));
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
              child: SvgPicture.asset("assets/imgs/cornerTL.svg", width: 150),
            ),
            Positioned(
              bottom: 40,
              right: 10,
              child: SvgPicture.asset("assets/imgs/cornerBR.svg", width: 150),
            ),
            Center(
              child: Column(
                children: [
                  Expanded(
                    child: SvgPicture.asset("assets/imgs/logo.svg", width: 250),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          Button(
                            title: "قضية جديدة",
                            onTap: () async {
                              if (kIsWeb) {
                                await AudioPlayer().play(
                                  UrlSource("assets/sounds/click.mp3"),
                                );
                              } else {
                                await AudioPlayer().play(
                                  AssetSource("sounds/click.mp3"),
                                );
                              }
                              if (context.mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AddPlayers(),
                                  ),
                                );
                              }
                            },
                          ),
                          Button(
                            title: "القضايا",
                            onTap: () async {
                              if (kIsWeb) {
                                await AudioPlayer().play(
                                  UrlSource("assets/sounds/click.mp3"),
                                );
                              } else {
                                await AudioPlayer().play(
                                  AssetSource("sounds/click.mp3"),
                                );
                              }
                              if (context.mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Issues(),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await launch(kAutherWebsite);
                    },
                    child: const Column(
                      children: [
                        Text(
                          "برمجة",
                          style: TextStyle(
                            color: Color(0xFF228272),
                            fontSize: 20,
                            letterSpacing: -1,
                          ),
                        ),
                        Text(
                          "سكيبر",
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
          ],
        ),
      ),
    );
  }
}

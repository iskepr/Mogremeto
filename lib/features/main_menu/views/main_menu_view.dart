import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:http/http.dart" as http;
import "package:url_launcher/url_launcher.dart";

import "../../../constants.dart";
import "../../../core/helpers/audio_helper.dart";
import "../../../core/helpers/hive_helper.dart";
import "../../../core/models/case_model.dart";
import "../../../core/utils/check_update.dart";
import "../../../core/widgets/button.dart";
import "../../cases/views/cases_view.dart";
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

  Future<void> getStories() async {
    try {
      final String localDataString = await rootBundle.loadString(
        kRoleplayStoriesPath,
      );
      final List<dynamic> localStoriesRaw = jsonDecode(localDataString);

      final List<Map<String, dynamic>> allStoriesMap = localStoriesRaw
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();

      try {
        final response = await http.get(Uri.parse(kApi));

        if (response.statusCode == 200) {
          final List<dynamic> remoteStories = json.decode(response.body);

          for (var story in remoteStories) {
            if (story == null || story is! Map) {
              debugPrint("القصة غير موجودة أو بتنسيق غير صحيح!");
              continue;
            }

            final storyId = story["id"];
            if (storyId == null) {
              debugPrint("القصة مفقود فيها ID!");
              continue;
            }

            final bool alreadyExists = allStoriesMap.any(
              (s) => s["id"].toString() == storyId.toString(),
            );

            if (!alreadyExists) {
              allStoriesMap.add(Map<String, dynamic>.from(story));
            }
          }
        } else {
          debugPrint(
            "فشل في تحميل البيانات من السيرفر! الكود: ${response.statusCode}",
          );
        }
      } catch (e) {
        debugPrint("حدث خطأ أثناء الاتصال بالسيرفر: $e");
      }

      final List<CaseModel> finalCaseModels = allStoriesMap
          .map((c) => CaseModel.fromMap(c))
          .toList();

      await HiveHelper.saveListData<CaseModel>(kBoxCases, finalCaseModels);

      debugPrint("تم حفظ ${finalCaseModels.length} قصة بنجاح في Hive!");
    } catch (e) {
      debugPrint("حدث خطأ رئيسي أثناء معالجة القصص: $e");
    }
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
                            onTap: () {
                              AudioHelper.runSound("click");
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
                            onTap: () {
                              AudioHelper.runSound("click");
                              if (context.mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const IssuesView(),
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

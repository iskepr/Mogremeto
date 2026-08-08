import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:shared_preferences/shared_preferences.dart";

class Issues extends StatefulWidget {
  const Issues({super.key});

  @override
  State<Issues> createState() => _IssuesState();
}

class _IssuesState extends State<Issues> {
  late List<Map<String, dynamic>> storiesInstance = [];
  List<String> issues = [];
  List<int> availableIds = [];
  List<int> usedIds = [];

  @override
  void initState() {
    super.initState();
    loadStories();
  }

  Future<void> loadStories() async {
    final prefs = await SharedPreferences.getInstance();
    final String? storedStories = prefs.getString("localStories");

    if (storedStories != null) {
      setState(() {
        storiesInstance = List<Map<String, dynamic>>.from(
          jsonDecode(storedStories),
        );
        issues = storiesInstance
            .map<String>((story) => story["type"].toString())
            .toList();
      });
      getStoryId();
    }
  }

  Future<void> getStoryId() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? doneStories = prefs.getStringList("doneStories");

    final List<int> savedIds = doneStories?.map(int.parse).toList() ?? [];
    setState(() {
      usedIds = savedIds;
      availableIds = List.generate(
        storiesInstance.length,
        (index) => index,
      ).where((id) => !savedIds.contains(id)).toList();
    });

    debugPrint("المحفوظة: $usedIds");
    debugPrint("المتاحة: $availableIds");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF822222),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "جميع القضايا",
                style: TextStyle(fontSize: 40, color: Color(0xFFFFF0CC)),
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(issues.length, (index) {
                  final String issue = issues[index];
                  final bool isSaved = usedIds.contains(index);

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF822222)),
                      color: const Color(0xFFFFF0CC),
                    ),
                    width: 100,
                    height: 120,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 10,
                          child: SvgPicture.asset(
                            "assets/imgs/cornerTL.svg",
                            width: 30,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: SvgPicture.asset(
                            "assets/imgs/cornerBR.svg",
                            width: 30,
                          ),
                        ),
                        Center(
                          child: Text(
                            issue,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSaved
                                  ? const Color(0xFF822222)
                                  : const Color(0xFF228272),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

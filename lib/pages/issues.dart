import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    String? storedStories = prefs.getString('localStories');

    if (storedStories != null) {
      setState(() {
        storiesInstance = List<Map<String, dynamic>>.from(
          jsonDecode(storedStories),
        );
        issues =
            storiesInstance
                .map<String>((story) => story["type"].toString())
                .toList();
      });
      getStoryId();
    }
  }

  Future<void> getStoryId() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? doneStories = prefs.getStringList('doneStories');

    List<int> savedIds = doneStories?.map(int.parse).toList() ?? [];
    setState(() {
      usedIds = savedIds;
      availableIds =
          List.generate(
            storiesInstance.length,
            (index) => index,
          ).where((id) => !savedIds.contains(id)).toList();
    });

    print("المحفوظة: $usedIds");
    print("المتاحة: $availableIds");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF822222),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // لجعل العنوان بالأعلى
            children: [
              const Text(
                'جميع القضايا',
                style: TextStyle(fontSize: 40, color: Color(0xFFFFF0CC)),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(issues.length, (index) {
                      String issue = issues[index];
                      bool isSaved = usedIds.contains(
                        index,
                      ); // التحقق مما إذا كان العنصر محفوظًا

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
                                'assets/imgs/cornerTL.svg',
                                width: 30,
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: SvgPicture.asset(
                                'assets/imgs/cornerBR.svg',
                                width: 30,
                              ),
                            ),
                            Center(
                              child: Text(
                                issue,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      isSaved
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

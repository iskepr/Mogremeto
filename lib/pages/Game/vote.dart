import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../pages/Game/dalel.dart';
import '../../pages/Game/doneGame.dart';
import '../../widgets/button.dart';

class Vote extends StatefulWidget {
  const Vote({
    super.key,
    required this.storyId,
    required this.dalelId,
    required this.outUsers,
  });

  final int storyId;
  final int dalelId;
  final List outUsers;

  @override
  State<Vote> createState() => _VoteState();
}

class _VoteState extends State<Vote> {
  List<dynamic>? storiesInstance;
  late List<Map<String, dynamic>> accused = [];

  @override
  void initState() {
    super.initState();
    loadStories(); // تحميل البيانات بشكل غير متزامن
  }

  Future<void> loadStories() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedStories = prefs.getString('localStories');

    if (storedStories != null) {
      List<dynamic> decodedStories = jsonDecode(storedStories);

      setState(() {
        storiesInstance = decodedStories;

        // التحقق مما إذا كان storyId صالحًا قبل الوصول إلى البيانات
        if (widget.storyId >= 0 &&
            widget.storyId < storiesInstance!.length &&
            storiesInstance![widget.storyId]['accused'] != null) {
          accused = List.generate(
            4,
            (i) =>
                (i < storiesInstance![widget.storyId]['accused'].length)
                    ? storiesInstance![widget.storyId]['accused'][i]
                    : {
                      'name': 'غير معروف',
                      'type': 'غير معروف',
                      'criminal': false,
                    },
          );
        } else {
          accused = List.generate(
            4,
            (i) => {
              'name': 'غير معروف',
              'type': 'غير معروف',
              'criminal': false,
            },
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF822222),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'حط التليفون قدام الكل',
              style: TextStyle(color: Color(0xFFFFF0CC), fontSize: 40),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children:
                    accused
                        .where(
                          (player) => !widget.outUsers.contains(player['type']),
                        )
                        .map(
                          (player) => Button(
                            title: player['type'],
                            onTap: () async {
                              widget.dalelId == 2 && !player['criminal']
                                  ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => DoneGame(
                                            storyId: widget.storyId,
                                            inTitle:
                                                'المُجرميتو كسب\nمعلش تعيشو وتاخدو غيرها',
                                            butTitle: "المُجرميتو فلت",
                                            soundName: 'faild',
                                          ),
                                    ),
                                  )
                                  : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              player['criminal']
                                                  ? DoneGame(
                                                    storyId: widget.storyId,
                                                    inTitle:
                                                        "الف مبروج قبضطم علي المجرميتو",
                                                    butTitle: "تم حل القضية",
                                                    soundName: 'intro',
                                                  )
                                                  : Dalel(
                                                    storyId: widget.storyId,
                                                    inTitle: 'بَريء',
                                                    dalelId: widget.dalelId + 1,
                                                    outUsers: [
                                                      player['type'],
                                                      ...widget.outUsers,
                                                    ],
                                                  ),
                                    ),
                                  );
                              if (kIsWeb) {
                                await AudioPlayer().play(
                                  UrlSource('assets/sounds/click.mp3'),
                                );
                              } else {
                                await AudioPlayer().play(
                                  AssetSource('sounds/click.mp3'),
                                );
                              }
                            },
                          ),
                        )
                        .toList(),
              ),
            ),
            SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}

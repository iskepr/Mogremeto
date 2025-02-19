import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../pages/Game/dalel.dart';
import '../../widgets/Card.dart';
import '../../widgets/button.dart';

class SetCharacter extends StatefulWidget {
  const SetCharacter({
    super.key,
    required this.player1,
    required this.player2,
    required this.player3,
    required this.player4,
    required this.storyId,
  });

  final String player1;
  final String player2;
  final String player3;
  final String player4;
  final int storyId;

  @override
  State<SetCharacter> createState() => _SetCharacterState();
}

class _SetCharacterState extends State<SetCharacter> {
  List<dynamic>? storiesInstance;
  int playerId = 0;
  bool flip = false;

  late int storyId;
  late String player;
  late String type;
  late bool isMogrem;

  @override
  void initState() {
    super.initState();
    storyId = widget.storyId;
    _updatePlayerData();
    loadStories();
  }

  Future<void> loadStories() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedStories = prefs.getString('localStories');

    if (storedStories != null) {
      List<dynamic> decodedStories = jsonDecode(storedStories);
      setState(() {
        storiesInstance = decodedStories;
      });

      if (decodedStories.isEmpty) {
        setState(() {
          storyId = -1;
        });
      } else {
        // تأكد من تحديث بيانات اللاعب بعد تحميل القصص
        _updatePlayerData();
      }
    }
  }

  void _updatePlayerData() {
    if (storiesInstance == null ||
        storyId == -1 ||
        storyId >= (storiesInstance?.length ?? 0)) {
      return;
    }

    setState(() {
      print("Updating player data for playerId: $playerId");

      switch (playerId) {
        case 0:
          player = widget.player1;
          break;
        case 1:
          player = widget.player2;
          break;
        case 2:
          player = widget.player3;
          break;
        case 3:
          player = widget.player4;
          break;
        default:
          player = 'غير معروف';
          return;
      }

      var currentStory = storiesInstance![storyId];

      if (currentStory.containsKey('accused') &&
          playerId < currentStory['accused'].length) {
        type = currentStory['accused'][playerId]['type'] ?? 'غير معروف';
        isMogrem = currentStory['accused'][playerId]['criminal'] ?? false;
      } else {
        type = 'غير معروف';
        isMogrem = false;
      }

      flip = false;
    });
  }

  void handle() {
    if (storiesInstance == null || storyId == -1) return;

    if (playerId == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => Dalel(
                storyId: storyId,
                inTitle: 'الجريمة هي\n${storiesInstance![storyId]['title']}',
                dalelId: 0,
                outUsers: [],
              ),
        ),
      );
    } else {
      setState(() {
        playerId++;
        _updatePlayerData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF0CC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'ادي التليفون ل$player',
              style: TextStyle(color: Color(0xFF228272), fontSize: 40),
            ),
            mogremetoCard(
              title: 'المهنة',
              subtitle: '$type\n${isMogrem ? '(مُجرميتو)' : ''}',
              flip: flip, // <-- تمرير حالة القلب إلى الكارت
              onFlip: () async {
                setState(() {
                  flip = !flip; // <-- عندما ينقلب الكارت، يتم تحديث حالته
                });
                if (kIsWeb) {
                  await AudioPlayer().play(
                    UrlSource('assets/sounds/flipcard.mp3'),
                  );
                } else {
                  await AudioPlayer().play(AssetSource('sounds/flipcard.mp3'));
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Button(title: 'التالي', onTap: handle),
            ),
          ],
        ),
      ),
    );
  }
}

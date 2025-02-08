import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mafuso/data/stories.dart';
import 'package:mafuso/pages/Game/dalel.dart';
import 'package:mafuso/widgets/Card.dart';
import 'package:mafuso/widgets/button.dart';

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
  final Stories storiesInstance = Stories();
  int playerId = 0;
  bool flip = false;

  late int storyId;
  late String player;
  late String type;
  late bool isMasfuso;

  @override
  void initState() {
    super.initState();
    storyId = widget.storyId;
    _updatePlayerData();
  }

  void _updatePlayerData() {
    setState(() {
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
      }
      type = storiesInstance.stories[storyId]['accused'][playerId]['type'];
      isMasfuso =
          storiesInstance.stories[storyId]['accused'][playerId]['criminal'];
      flip = false;
    });
  }

  void handle() {
    if (playerId == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => Dalel(
                storyId: storyId,
                inTitle:
                    'الجريمة هي\n${storiesInstance.stories[storyId]['title']}',
                dalelId: 0,
                outUsers: [],
              ),
        ),
      );
    } else {
      playerId++;
      _updatePlayerData();
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
            MafusoCard(
              title: 'المهنة',
              subtitle: '$type\n${isMasfuso ? '(مافيوسو)' : ''}',
              flip: flip, // <-- تمرير حالة القلب إلى الكارت
              onFlip: () {
                setState(() {
                  flip = !flip; // <-- عندما ينقلب الكارت، يتم تحديث حالته
                });
                AudioPlayer().play(UrlSource('assets/sounds/flipcard.mp3'));
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

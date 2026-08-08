import "package:flutter/material.dart";

import "../../../../core/helpers/audio_helper.dart";
import "../../../../core/models/data_typs.dart";
import "../../../../core/widgets/button.dart";
import "card_view.dart";
import "dalel.dart";

class SetCharacter extends StatefulWidget {
  const SetCharacter({
    super.key,
    required this.player1,
    required this.player2,
    required this.player3,
    required this.player4,
    required this.caseData,
  });

  final String player1;
  final String player2;
  final String player3;
  final String player4;
  final CaseModel caseData;

  @override
  State<SetCharacter> createState() => _SetCharacterState();
}

class _SetCharacterState extends State<SetCharacter> {
  int playerIndex = 0;
  bool flip = false;

  late CaseModel caseData;
  late Suspect suspect;
  late String playerName;

  @override
  void initState() {
    super.initState();
    caseData = widget.caseData;
    _updatePlayerData();
  }

  void _updatePlayerData() {
    setState(() {
      debugPrint("Updating player data for playerId: $playerIndex");

      switch (playerIndex) {
        case 0:
          playerName = widget.player1;
        case 1:
          playerName = widget.player2;
        case 2:
          playerName = widget.player3;
        case 3:
          playerName = widget.player4;
        default:
          playerName = "غير معروف";
          return;
      }
      suspect = caseData.suspects[playerIndex];

      flip = false;
    });
  }

  void handle() {
    if (playerIndex == (caseData.suspects.length - 1)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Dalel(
            caseData: caseData,
            inTitle: "الجريمة هي\n${caseData.title}",
            dalelId: 0,
            outUsers: const [],
          ),
        ),
      );
    } else {
      setState(() {
        playerIndex++;
        _updatePlayerData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0CC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "ادي التليفون ل$playerName",
              style: const TextStyle(color: Color(0xFF228272), fontSize: 40),
            ),
            CardView(
              title: "المهنة",
              subtitle:
                  "${suspect.name}\n${suspect.isCulprit ? "(مُجرميتو)" : ""}",
              flip: flip,
              onFlip: () {
                setState(() => flip = !flip);
                AudioHelper.runSound("flipcard");
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Button(title: "التالي", onTap: handle),
            ),
          ],
        ),
      ),
    );
  }
}

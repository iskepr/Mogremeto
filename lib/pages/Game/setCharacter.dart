import 'package:flutter/material.dart';
import 'package:mafuso/widgets/Card.dart';
import 'package:mafuso/widgets/button.dart';

class SetCharacter extends StatelessWidget {
  const SetCharacter({
    super.key,
    required this.player1,
    required this.player2,
    required this.player3,
    required this.player4,
  });
  final String player1;
  final String player2;
  final String player3;
  final String player4;

  @override
  Widget build(BuildContext context) {
    String player = player1;
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
            MafusoCard(character: 'ظابط (مافيوسو)'),
            Button(
              title: 'التالي',
              page: SetCharacter(
                player1: player1,
                player2: player2,
                player3: player3,
                player4: player4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

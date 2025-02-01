import 'package:flutter/material.dart';
import 'package:mafuso/data/stories.dart';
import 'package:mafuso/pages/Game/dalel.dart';
import 'package:mafuso/widgets/button.dart';

class Vote extends StatefulWidget {
  const Vote({super.key, required this.storyId, required this.dalelId});
  final int storyId;
  final int dalelId;

  @override
  State<Vote> createState() => _VoteState();
}

class _VoteState extends State<Vote> {
  final Stories storiesInstance = Stories();
  late int storyId;
  late int dalelId;
  late String player1;
  late String player2;
  late String player3;
  late String player4;

  @override
  void initState() {
    super.initState();
    storyId = widget.storyId;
    dalelId = widget.dalelId;
    player1 = storiesInstance.stories[storyId]['accused'][0]['type'];
    player2 = storiesInstance.stories[storyId]['accused'][1]['type'];
    player3 = storiesInstance.stories[storyId]['accused'][2]['type'];
    player4 = storiesInstance.stories[storyId]['accused'][3]['type'];
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
                children: [
                  Button(title: player1, onTap: () {}),
                  Button(title: player2, onTap: () {}),
                  Button(title: player3, onTap: () {}),
                  Button(title: player4, onTap: () {}),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Button(
                title: 'الدليل التالي',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Dalel(storyId: storyId),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mafuso/data/stories.dart';
import 'package:mafuso/pages/Game/dalel.dart';
import 'package:mafuso/pages/Game/doneGame.dart';
import 'package:mafuso/widgets/button.dart';

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
  final Stories storiesInstance = Stories();
  late List<Map<String, dynamic>> accused;

  @override
  void initState() {
    super.initState();
    accused = List.generate(
      4,
      (i) => storiesInstance.stories[widget.storyId]['accused'][i],
    );
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
                            onTap: () {
                              widget.dalelId == 2 && !player['criminal']
                                  ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => DoneGame(
                                            storyId: widget.storyId,
                                            inTitle:
                                                'المُجرميتو كسب\nمعلش تعيشو وتاخدو غيرها',
                                            butTitle: "المُجرميتو فلت", soundName: 'faild',
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
                                                    butTitle: "تم حل القضية", soundName: 'intro',
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
                              AudioPlayer().play(
                                UrlSource('assets/sounds/click.mp3'),
                              );
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

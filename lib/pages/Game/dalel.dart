import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mafuso/data/stories.dart';
import 'package:mafuso/pages/Game/vote.dart';
import 'package:mafuso/widgets/Card.dart';
import 'package:mafuso/widgets/button.dart';

class Dalel extends StatefulWidget {
  const Dalel({super.key, required this.storyId});
  final int storyId;

  @override
  State<Dalel> createState() => _DalelState();
}

class _DalelState extends State<Dalel> {
  final Stories storiesInstance = Stories();
  late int storyId;
  int dalelId = 0;
  late String dalelTitle;
  bool isFlip = false;
  bool showCard = true;
  double cardOpacity = 0;

  @override
  void initState() {
    super.initState();
    storyId = widget.storyId;
    dalelTitle = storiesInstance.stories[storyId]['evidence'][dalelId];
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        cardOpacity = 1;
      });
      Timer(const Duration(seconds: 5), () {
        setState(() {
          cardOpacity = 0;
        });
        Timer(const Duration(seconds: 3), () {
          setState(() {
            showCard = false;
            cardOpacity = 0;
          });
          Timer(const Duration(seconds: 1), () {
            setState(() {
              cardOpacity = 1;
              isFlip = true;
            });
          });
        });
      });
    });
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
            showCard
                ? AnimatedOpacity(
                  opacity: cardOpacity,
                  duration: Duration(seconds: 2),
                  child: SizedBox(
                    height: 280,
                    child: Center(
                      child: Text(
                        'الجريمة هي\n${storiesInstance.stories[storyId]['title']}',
                        style: TextStyle(
                          color: Color(0xFFFFF0CC),
                          fontSize: 60,
                        ),
                      ),
                    ),
                  ),
                )
                : AnimatedOpacity(
                  opacity: cardOpacity,
                  duration: Duration(seconds: 1),
                  child: MafusoCard(
                    title: 'الدليل الاول',
                    subtitle: dalelTitle,
                    flip: isFlip,
                    onFlip: () {},
                  ),
                ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child:
                  showCard
                      ? SizedBox(height: 90)
                      : AnimatedOpacity(
                        opacity: cardOpacity,
                        duration: Duration(seconds: 1),
                        child: Button(
                          title: 'إالي التصويت',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => Vote(
                                      storyId: storyId,
                                      dalelId: dalelId,
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

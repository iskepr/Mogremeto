import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mafuso/data/stories.dart';
import 'package:mafuso/pages/Game/vote.dart';
import 'package:mafuso/widgets/Card.dart';
import 'package:mafuso/widgets/button.dart';

class Dalel extends StatefulWidget {
  const Dalel({
    super.key,
    required this.storyId,
    required this.inTitle,
    required this.dalelId,
    required this.outUsers,
  });
  final int storyId;
  final int dalelId;
  final String inTitle;
  final List outUsers;

  @override
  State<Dalel> createState() => _DalelState();
}

class _DalelState extends State<Dalel> {
  final Stories storiesInstance = Stories();
  late int storyId;
  late String dalelTitle;
  bool isFlip = false;
  bool showCard = true;
  double cardOpacity = 0;
  String dalelNum = '';

  @override
  void initState() {
    super.initState();
    storyId = widget.storyId;
    dalelTitle = storiesInstance.stories[storyId]['evidence'][widget.dalelId];

    if (widget.dalelId == 0) {
      dalelNum = 'الدليل الاول';
    } else if (widget.dalelId == 1) {
      dalelNum = 'الدليل الثاني';
    } else if (widget.dalelId == 2) {
      dalelNum = 'الدليل الثالث';
    }

    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        cardOpacity = 1;
      });
      if (kIsWeb) {
        AudioPlayer().play(UrlSource('assets/sounds/intro.mp3'));
      } else {
        AudioPlayer().play(AssetSource('sounds/intro.mp3'));
      }
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
            if (kIsWeb) {
              AudioPlayer().play(UrlSource('assets/sounds/flipcard.mp3'));
            } else {
              AudioPlayer().play(AssetSource('sounds/flipcard.mp3'));
            }
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
                        widget.inTitle,
                        textAlign: TextAlign.center,
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
                    title: dalelNum,
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
                          title: 'إلي التصويت',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => Vote(
                                      storyId: storyId,
                                      dalelId: widget.dalelId,
                                      outUsers: widget.outUsers,
                                    ),
                              ),
                            );
                            print(widget.outUsers);
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

import "package:flutter/material.dart";

import "../../../../core/helpers/audio_helper.dart";
import "../../../../core/models/data_typs.dart";
import "../../../../core/widgets/button.dart";
import "dalel.dart";
import "done_game_view.dart";

class VoteView extends StatelessWidget {
  const VoteView({
    super.key,
    required this.caseData,
    required this.dalelId,
    required this.outUsers,
  });

  final CaseModel caseData;
  final int dalelId;
  final List outUsers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF822222),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "حط التليفون قدام الكل",
              style: TextStyle(color: Color(0xFFFFF0CC), fontSize: 40),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: caseData.suspects
                    .where((player) => !outUsers.contains(player.name))
                    .map(
                      (player) => Button(
                        title: player.name,
                        onTap: () {
                          dalelId == 2 && !player.isCulprit
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DoneGameView(
                                      caseData: caseData,
                                      inTitle:
                                          "المُجرميتو كسب\nمعلش تعيشو وتاخدو غيرها",
                                      butTitle: "المُجرميتو فلت",
                                      soundName: "faild",
                                    ),
                                  ),
                                )
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => player.isCulprit
                                        ? DoneGameView(
                                            caseData: caseData,
                                            inTitle:
                                                "الف مبروج قبضطم علي المُجرميتو",
                                            butTitle: "تم حل القضية",
                                            soundName: "intro",
                                          )
                                        : Dalel(
                                            caseData: caseData,
                                            inTitle: "بَريء",
                                            dalelId: dalelId + 1,
                                            outUsers: [
                                              player.name,
                                              ...outUsers,
                                            ],
                                          ),
                                  ),
                                );
                          AudioHelper.runSound("click");
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}

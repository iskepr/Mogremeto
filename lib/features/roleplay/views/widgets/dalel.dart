import "dart:async";

import "package:flutter/material.dart";

import "../../../../core/helpers/audio_helper.dart";
import "../../../../core/models/data_typs.dart";
import "../../../../core/widgets/button.dart";
import "card_view.dart";
import "vote.dart";

class Dalel extends StatefulWidget {
  const Dalel({
    super.key,
    required this.caseData,
    required this.inTitle,
    required this.dalelId,
    required this.outUsers,
  });
  final CaseModel caseData;
  final int dalelId;
  final String inTitle;
  final List outUsers;

  @override
  State<Dalel> createState() => _DalelState();
}

class _DalelState extends State<Dalel> {
  late CaseModel caseData;
  late String dalelTitle;
  late String dalelNum;
  bool isFlip = false;
  bool showCard = true;
  double cardOpacity = 0;

  @override
  void initState() {
    super.initState();
    caseData = widget.caseData;

    switch (widget.dalelId) {
      case 0:
        dalelNum = "الدليل الأول";
      case 1:
        dalelNum = "الدليل الثاني";
      case 2:
        dalelNum = "الدليل الثالث";
      default:
        dalelNum = "دليل غير معروف";
    }

    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        cardOpacity = 1;
      });
      AudioHelper.runSound("intro");

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
          AudioHelper.runSound("flipcard");
        });
      });
    });
  }

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
            showCard
                ? AnimatedOpacity(
                    opacity: cardOpacity,
                    duration: const Duration(seconds: 2),
                    child: SizedBox(
                      height: 280,
                      child: Center(
                        child: Text(
                          widget.inTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFFFFF0CC),
                            fontSize: 60,
                          ),
                        ),
                      ),
                    ),
                  )
                : AnimatedOpacity(
                    opacity: cardOpacity,
                    duration: const Duration(seconds: 1),
                    child: CardView(
                      title: dalelNum,
                      subtitle: dalelTitle,
                      flip: isFlip,
                      onFlip: () {},
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: showCard
                  ? const SizedBox(height: 90)
                  : AnimatedOpacity(
                      opacity: cardOpacity,
                      duration: const Duration(seconds: 1),
                      child: Button(
                        title: "إلي التصويت",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Vote(
                                caseData: caseData,
                                dalelId: widget.dalelId,
                                outUsers: widget.outUsers,
                              ),
                            ),
                          );
                          debugPrint(widget.outUsers.toString());
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

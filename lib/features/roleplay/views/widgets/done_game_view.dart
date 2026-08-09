import "dart:async";

import "package:flutter/material.dart";

import "../../../../core/data/app_data.dart";
import "../../../../core/helpers/audio_helper.dart";
import "../../../../core/helpers/hive_helper.dart";
import "../../../../core/models/data_typs.dart";
import "../../../../core/widgets/button.dart";
import "../../../main_menu/views/main_menu_view.dart";

class DoneGameView extends StatefulWidget {
  const DoneGameView({
    super.key,
    required this.caseData,
    required this.inTitle,
    required this.butTitle,
    required this.soundName,
  });
  final CaseModel caseData;
  final String inTitle;
  final String butTitle;
  final String soundName;

  @override
  State<DoneGameView> createState() => _DoneGameViewState();
}

class _DoneGameViewState extends State<DoneGameView> {
  List<dynamic>? storiesInstance;
  bool showStory = false;
  double cardOpacity = 0;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        cardOpacity = 1;
      });
      AudioHelper.runSound(widget.soundName);
      Timer(const Duration(seconds: 3), () {
        setState(() {
          cardOpacity = 0;
        });
        Timer(const Duration(seconds: 2), () {
          setState(() {
            showStory = true;
            cardOpacity = 0;
          });
          Timer(const Duration(seconds: 1), () {
            setState(() {
              cardOpacity = 1;
            });
          });
        });
      });
    });
  }

  Future<void> saveDoneId() async {
    final doneCases = AppData.doneCasesIds;
    doneCases.add(widget.caseData.id);
    HiveHelper.saveListData(kBoxDoneCases, doneCases);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0CC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "حط التليفون قدام الكل",
              style: TextStyle(color: Color(0xFF228272), fontSize: 40),
            ),
            showStory
                ? AnimatedOpacity(
                    opacity: cardOpacity,
                    duration: const Duration(seconds: 1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        widget.caseData.story,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF822222),
                          fontSize: 35,
                        ),
                      ),
                    ),
                  )
                : AnimatedOpacity(
                    opacity: cardOpacity,
                    duration: const Duration(seconds: 1),
                    child: SizedBox(
                      height: 250,
                      child: Center(
                        child: Text(
                          widget.inTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF822222),
                            fontSize: 45,
                          ),
                        ),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Button(
                title: widget.butTitle,
                onTap: () {
                  saveDoneId();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainMenuView(),
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

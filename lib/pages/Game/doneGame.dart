import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../models/adModel.dart';
import '../../widgets/button.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class DoneGame extends StatefulWidget {
  const DoneGame({
    super.key,
    required this.storyId,
    required this.inTitle,
    required this.butTitle,
    required this.soundName,
  });
  final int storyId;
  final String inTitle;
  final String butTitle;
  final String soundName;

  @override
  State<DoneGame> createState() => _DoneGameState();
}

class _DoneGameState extends State<DoneGame> {
  List<dynamic>? storiesInstance;
  bool showStory = false;
  double cardOpacity = 0;

  @override
  void initState() {
    super.initState();
    loadStories();
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        cardOpacity = 1;
      });
      if (kIsWeb) {
        AudioPlayer().play(UrlSource('assets/sounds/${widget.soundName}.mp3'));
      } else {
        AudioPlayer().play(AssetSource('sounds/${widget.soundName}.mp3'));
      }
      Timer(const Duration(seconds: 5), () {
        setState(() {
          cardOpacity = 0;
        });
        Timer(const Duration(seconds: 3), () {
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

  Future<void> loadStories() async {
  final prefs = await SharedPreferences.getInstance();
  String? storedStories = prefs.getString('localStories');

  if (storedStories != null) {
    List<dynamic> decodedStories = jsonDecode(storedStories);
    
    setState(() {
      storiesInstance = decodedStories;
    });
  }
}

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    // جلب القائمة الحالية من SharedPreferences
    List<String>? doneStories = prefs.getStringList('doneStories');

    // إذا كانت القائمة فارغة، ننشئ قائمة جديدة
    doneStories ??= [];

    // إضافة الـ ID الجديد إلى القائمة
    if (!doneStories.contains(widget.storyId.toString())) {
      doneStories.add(widget.storyId.toString());
    }

    // حفظ القائمة المحدثة
    await prefs.setStringList('doneStories', doneStories);
    print(prefs.getStringList('doneStories'));
  }

  RewardedAd? _rewardedAd;

  void loadAd() {
    RewardedAd.load(
      adUnitId: AdModel.adUnitawardId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('RewardedAd failed to load: $error');
        },
      ),
    );
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
              'حط التليفون قدام الكل',
              style: TextStyle(color: Color(0xFF228272), fontSize: 40),
            ),
            showStory
                ? AnimatedOpacity(
                  opacity: cardOpacity,
                  duration: Duration(seconds: 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      storiesInstance?[widget.storyId]['story'],
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF822222), fontSize: 35),
                    ),
                  ),
                )
                : AnimatedOpacity(
                  opacity: cardOpacity,
                  duration: Duration(seconds: 1),
                  child: SizedBox(
                    height: 250,
                    child: Center(
                      child: Text(
                        widget.inTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
                  saveData();
                  if (_rewardedAd != null) {
                    _rewardedAd!.show(
                      onUserEarnedReward: (
                        AdWithoutView ad,
                        RewardItem reward,
                      ) {
                        debugPrint(
                          'User earned reward: ${reward.amount} ${reward.type}',
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Mogremeto()),
                        );
                      },
                    );
                  } else {
                    debugPrint('Ad not loaded yet. Loading now...');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Mogremeto()),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mafuso/pages/Game/addPlayers.dart';
import 'package:mafuso/pages/issues.dart';
import 'package:mafuso/widgets/button.dart';
import 'package:mafuso/models/adModel.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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
      backgroundColor: const Color(0xFFFFF0CC),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: 30,
              left: 10,
              child: SvgPicture.asset('assets/imgs/cornerTL.svg', width: 150),
            ),
            Positioned(
              bottom: 30,
              right: 10,
              child: SvgPicture.asset('assets/imgs/cornerBR.svg', width: 150),
            ),
            Center(
              child: Column(
                children: [
                  Expanded(
                    child: SvgPicture.asset('assets/imgs/logo.svg', width: 250),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          Button(
                            title: 'قضية جديدة',
                            onTap: () async {
                              if (kIsWeb) {
                                await AudioPlayer().play(
                                  UrlSource('assets/sounds/click.mp3'),
                                );
                              } else {
                                await AudioPlayer().play(
                                  AssetSource('sounds/click.mp3'),
                                );
                              }
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
                                      MaterialPageRoute(
                                        builder: (context) => AddPlayers(),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                debugPrint('Ad not loaded yet. Loading now...');
                                // loadAd();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddPlayers(),
                                  ),
                                );
                              }
                            },
                          ),
                          Button(
                            title: 'القضايا',
                            onTap: () async {
                              if (kIsWeb) {
                                await AudioPlayer().play(
                                  UrlSource('assets/sounds/click.mp3'),
                                );
                              } else {
                                await AudioPlayer().play(
                                  AssetSource('sounds/click.mp3'),
                                );
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Issues(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 150),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:url_launcher/url_launcher.dart";

import "../../../constants.dart";
import "../../main_menu/views/main_menu_view.dart";

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  double screenOpacity = 1.0;
  double splashOpacity = 0;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      setState(() => splashOpacity = 1);
      Timer(const Duration(seconds: 4), () {
        setState(() => screenOpacity = 0.0);
        Timer(const Duration(milliseconds: 800), () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const MainMenuView(),
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
            ),
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        opacity: splashOpacity,
        duration: const Duration(seconds: 1),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset("assets/imgs/logo.svg", width: 400),
                GestureDetector(
                  onTap: () async {
                    await launch(kAutherWebsite);
                  },
                  child: const Column(
                    children: [
                      Text(
                        "برمجة",
                        style: TextStyle(
                          color: Color(0xFF228272),
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "سكِيبر",
                        style: TextStyle(
                          color: Color(0xFFFFF0CC),
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../pages/menu.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double screenOpacity = 1.0;
  double splashOpacity = 0;

  @override
  void initState() {
    super.initState();
    // بعد 4 ثوانٍ، اجعل الصفحة تبدأ في الاختفاء
    Timer(const Duration(seconds: 1), () {
      setState(() {
        splashOpacity = 1;
      });
      Timer(const Duration(seconds: 4), () {
        setState(() {
          screenOpacity = 0.0;
        });
        // بعد انتهاء الأنميشن، انتقل إلى صفحة المينيو
        Timer(const Duration(milliseconds: 800), () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => Menu(),
              transitionDuration: Duration(milliseconds: 500), // مدة الاختفاء
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
        duration: Duration(seconds: 1), // مدة الاختفاء
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset('assets/imgs/logo.svg', width: 400),
                GestureDetector(
                  onTap: () async {
                    await launch("https://iskepr.github.io");
                  },
                  child: Column(
                    children: [
                      Text(
                        'برمجة',
                        style: TextStyle(
                          color: Color(0xFF228272),
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'سكِيبر',
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

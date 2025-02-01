import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mafuso/pages/Game/addPlayers.dart';
import 'package:mafuso/pages/issues.dart';
import 'package:mafuso/pages/settings.dart';
import 'package:mafuso/widgets/button.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0CC),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: SvgPicture.asset('assets/imgs/cornerTL.svg', width: 150),
            ),
            Positioned(
              bottom: 10,
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddPlayers(),
                                ),
                              );
                            },
                          ),
                          Button(
                            title: 'القضايا',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Issues()),
                              );
                            },
                          ),
                          Button(
                            title: 'الاعدادات',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Settings(),
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

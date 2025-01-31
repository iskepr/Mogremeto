import 'package:flutter/material.dart';
import 'package:mafuso/pages/menu.dart';

void main() {
  runApp(const Mafuso());
}

class Mafuso extends StatelessWidget {
  const Mafuso({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'مافيوسو',
      theme: ThemeData(
        fontFamily: 'foda',
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF822222), fontSize: 20),
          bodyMedium: TextStyle(color: Color(0xFFFFF0CC), fontSize: 20),
          bodySmall: TextStyle(color: Color(0xFF228272), fontSize: 20),
        ),
        scaffoldBackgroundColor: Color(0xFF822222),
      ),
      routes: {'/': (context) => Menu(), '/البداية': (context) => Menu()},
    );
  }
}

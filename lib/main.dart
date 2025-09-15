import 'package:flutter/material.dart';
import 'widgets/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Mogremeto());
}

class Mogremeto extends StatelessWidget {
  const Mogremeto({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'مُجرميتو',
      theme: ThemeData(
        fontFamily: 'foda',
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF822222), fontSize: 20),
          bodyMedium: TextStyle(color: Color(0xFFFFF0CC), fontSize: 20),
          bodySmall: TextStyle(color: Color(0xFF228272), fontSize: 20),
        ),
        scaffoldBackgroundColor: Color(0xFF822222),
      ),
      routes: {'/': (context) => Splash()},
    );
  }
}

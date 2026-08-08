import "package:flutter/material.dart";
import "package:flutter_localizations/flutter_localizations.dart";

import "core/data/app_data.dart";
import "core/helpers/hive_helper.dart";
import "features/splash/views/splash_view.dart";
import "generated/l10n.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveHelper.init();
  AppData.init();

  runApp(const Mogremeto());
}

class Mogremeto extends StatelessWidget {
  const Mogremeto({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "مُجرميتو",

      // لغة التطبيق
      locale: const Locale("ar"),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,

      theme: ThemeData(
        fontFamily: "foda",
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF822222), fontSize: 20),
          bodyMedium: TextStyle(color: Color(0xFFFFF0CC), fontSize: 20),
          bodySmall: TextStyle(color: Color(0xFF228272), fontSize: 20),
        ),
        scaffoldBackgroundColor: const Color(0xFF822222),
      ),
      routes: {"/": (context) => const SplashView()},
    );
  }
}

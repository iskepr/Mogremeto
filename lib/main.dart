
import 'package:flutter/material.dart';
import 'widgets/splash.dart';

import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://phikpklispzjtqnhlwso.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBoaWtwa2xpc3B6anRxbmhsd3NvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk5ODQ1MzQsImV4cCI6MjA1NTU2MDUzNH0.IyMavDFi3w16ulxuaEqcnB2btP8GkDc27Pd_bDwGtzk',
  );
  runApp(const mogremeto());
}

class mogremeto extends StatelessWidget {
  const mogremeto({super.key});

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

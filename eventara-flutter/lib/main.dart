import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'features/landing/landing_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Force portrait — landing page is a single-column scrollable layout
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // Make the status bar transparent so the dark background bleeds through
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const EventaraApp());
}

class EventaraApp extends StatelessWidget {
  const EventaraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eventara',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7B5CF6),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFF0D0B1E),
      ),
      home: const LandingPage(),
    );
  }
}

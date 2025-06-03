import 'package:flutter/material.dart';
import 'package:moodtrack/screens/splashscreen.dart';

// Import all the screen files
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/mood_history_screen.dart';
import 'screens/mood_stats_screen.dart';
import 'screens/new_feature_screen.dart'; // ✅ Import new screen

class MoodTrackerApp extends StatelessWidget {
  const MoodTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Tracker',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/login': (_) => const LoginScreen(),
        '/home': (_) => const HomeScreen(),
        '/history': (_) => const MoodHistoryScreen(),
        '/stats': (_) => const MoodStatsScreen(),
        '/new-feature': (_) => const NewFeatureScreen(), // ✅ Add this line
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:test_flutter/homeScreen.dart';
import 'package:test_flutter/payment_screen.dart';
import 'package:test_flutter/project_detail_screen.dart';
import 'package:test_flutter/project_list_screen.dart';
import 'package:test_flutter/review_screen.dart';
import 'package:test_flutter/settings_screen.dart';
import 'package:test_flutter/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Define initial route to SplashScreen
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(), // SplashScreen as the initial route
        '/home': (context) => const HomeScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/project-list': (context) => const ProjectListScreen(),
        '/project-detail': (context) => ProjectDetailScreen(
            project: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/review': (context) => ReviewScreen(
            project: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/payment': (context) => PaymentScreen(
            project: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
      },
    );
  }
}

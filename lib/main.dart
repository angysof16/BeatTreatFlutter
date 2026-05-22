import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'screens/auth_screen.dart';

void main() {
  runApp(const BeatTreatApp());
}

class BeatTreatApp extends StatelessWidget {
  const BeatTreatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeatTreat',
      debugShowCheckedModeBanner: false,
      theme: beatTreatTheme(),
      home: const AuthScreen(),
    );
  }
}

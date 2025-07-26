import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(ClashPlannerApp());

class ClashPlannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clash Planner',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: HomeScreen(),
    );
  }
}

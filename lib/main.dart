import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/dashboard/dashboard_screen.dart';

void main() {
  runApp(const RegalConstructionApp());
}

class RegalConstructionApp extends StatefulWidget {
  const RegalConstructionApp({Key? key}) : super(key: key);

  @override
  State<RegalConstructionApp> createState() => _RegalConstructionAppState();
}

class _RegalConstructionAppState extends State<RegalConstructionApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Regal Construction',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

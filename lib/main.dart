import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, ThemeMode themeMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MinangXXI',
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Colors.grey[900],
            useMaterial3: true,
          ),
          themeMode: themeMode,
          home: HomeScreen(themeNotifier: themeNotifier),
        );
      },
    );
  }
}

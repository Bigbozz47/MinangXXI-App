import 'package:final_project/screens/home_screen.dart';
import 'package:final_project/widgets/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MinangXXI',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colours.scaffoldBgColor,
        // ignore: deprecated_member_use
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

import 'package:final_project/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'setting_screen.dart';
import 'movie_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.index, required this.themeNotifier});

  final int? index;
  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    if (widget.index != null) {
      _selectedIndex = widget.index!;
    }
    super.initState();
  }

  final _destination = [
    const NavigationDestination(icon: Icon(Icons.home), label: "Home"),
    const NavigationDestination(icon: Icon(Icons.search), label: "Search"),
    const NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
  ];

  @override
  Widget build(BuildContext context) {
    final _screens = [
      const MovieScreen(),
      SearchScreen(),
      SettingScreen(themeNotifier: widget.themeNotifier),
    ];

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        elevation: 12,
        selectedIndex: _selectedIndex,
        destinations: _destination,
        onDestinationSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:final_project/styles/padding.dart';

class SettingScreen extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const SettingScreen({super.key, required this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: Paddings.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThemeSwitchWidget(themeNotifier: themeNotifier),
          ],
        ),
      ),
    );
  }
}

class ThemeSwitchWidget extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const ThemeSwitchWidget({super.key, required this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, themeMode, _) {
        // Menentukan teks label berdasarkan tema
        final labelText =
            themeMode == ThemeMode.dark ? 'Dark Mode' : 'Light Mode';

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(labelText),
            Switch.adaptive(
              value: themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
              },
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Text('主题'),
      ),
    );
  }
}

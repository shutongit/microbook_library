import 'package:flutter/material.dart';
import 'package:microbook_library/router/router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(primaryColor: const Color(0xFFFFFFFF)),
      routerConfig: routes,
    );
  }
}

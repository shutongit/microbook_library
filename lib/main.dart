import 'package:flutter/material.dart';
import 'package:microbook_library/router/router.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
        child: MaterialApp.router(
      theme: ThemeData(primaryColor: const Color(0xFFFFFFFF)),
      routerConfig: routes,
    ));
  }
}

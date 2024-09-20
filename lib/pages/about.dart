import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint('about');
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      child: Text('关于'),
    );
  }
}

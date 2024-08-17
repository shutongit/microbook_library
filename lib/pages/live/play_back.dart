import 'package:flutter/material.dart';

class PlayBack extends StatefulWidget {
  const PlayBack({super.key, required this.time});

  final String time;

  @override
  State<PlayBack> createState() => _PlayBackState();
}

class _PlayBackState extends State<PlayBack> {
  @override
  void initState() {
    super.initState();
    debugPrint('initState${widget.time}');
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

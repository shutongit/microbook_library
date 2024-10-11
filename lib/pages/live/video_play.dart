import 'package:flutter/material.dart';
import 'package:microbook_library/base/page.dart';
import 'package:microbook_library/widgets/micro/web.dart';

class VideoPlay extends BasePage {
  final String videoUrl;
  const VideoPlay({super.key, required this.videoUrl});

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends BasePageState<VideoPlay> {
  @override
  Widget buildBody() {
    return WebViewExample(url: widget.videoUrl);
  }
}

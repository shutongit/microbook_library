import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

class VideoPlay extends StatefulWidget {
  const VideoPlay({super.key, required this.videoUrl});
  final String videoUrl;
// style.refererString = @"http://prog1.cretech.cn"; 视频播放防盗链
// ?signature=your-signature 链接后面跟上参数做防盗链
  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    debugPrint('widget.videoUrl: ${widget.videoUrl}');
    initPlayer();
    // _videoController =
    //     VideoPlayerController.contentUri(Uri.parse(widget.videoUrl))
    //       ..initialize().then((val) {
    //         _videoController.play();
    //       });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  /// 创建视频播放器
  void initPlayer() async {
    _videoController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));

    final subtitles = [
      Subtitle(
        index: 0,
        start: Duration.zero,
        end: const Duration(seconds: 10),
        text: const TextSpan(
          text: 'Hello',
          // children: [
          //   TextSpan(
          //     text: 'Hello',
          //     style: TextStyle(color: Colors.red, fontSize: 22),
          //   ),
          //   TextSpan(
          //     text: ' from ',
          //     style: TextStyle(color: Colors.green, fontSize: 20),
          //   ),
          //   TextSpan(
          //     text: 'subtitles',
          //     style: TextStyle(color: Colors.blue, fontSize: 18),
          //   )
          // ],
        ),
      ),
      Subtitle(
        index: 0,
        start: const Duration(seconds: 10),
        end: const Duration(seconds: 20),
        text: 'Whats up? :)',
      ),
    ];
    _videoController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: true,
        looping: true,
        subtitle: Subtitles(subtitles),
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              // if (context.canPop()) {
              //   context.pop();
              // }
              context.push('/');
            },
          ),
          title: const Text('视频播放'),
        ),
        body: widget.videoUrl.isNotEmpty
            ? Center(
                child: _chewieController != null
                    ? Chewie(controller: _chewieController!)
                    : const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 20),
                            Text('Loading'),
                          ],
                        ),
                      ),
              )
            : const Text('链接为空'));
  }
}

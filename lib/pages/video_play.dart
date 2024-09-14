import 'dart:async';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

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
  bool _isDownloading = true;
  String? _localFilePath;

  @override
  void initState() {
    super.initState();
    _downloadVideo();

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
    // _videoController =
    //     VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    debugPrint('_localFilePath: $_localFilePath');
    _videoController = VideoPlayerController.file(File(_localFilePath ?? ''));
    final subtitles = [
      Subtitle(
        index: 0,
        start: Duration.zero,
        end: const Duration(seconds: 10),
        text: const TextSpan(
          text: 'Hello',
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
      _videoController.play();
    });
  }

  /// 下载视频
  Future<void> _downloadVideo() async {
    try {
      final client = HttpClient();

      final request = await client.getUrl(Uri.parse(widget.videoUrl));
      request.headers.add('Referer', 'https://playback.cretech.cn');
      final response = await request.close();

      // 获取应用的临时目录
      var dir = await getTemporaryDirectory();
      debugPrint('dir:$dir');
      String filePath = '${dir.path}/video.mp4';
      debugPrint('filePath:$filePath');

      // 创建本地文件用于保存视频
      final file = File(filePath);
      final raf = file.openSync(mode: FileMode.write);
      debugPrint('response:$response');

      // 写入文件
      // 手动将流写入文件
      await response.forEach((chunk) {
        debugPrint('chunk:$chunk');
        raf.writeFromSync(chunk);
      });
      // await response.pipe(raf as StreamConsumer<List<int>>);
      await raf.close();

      setState(() {
        _localFilePath = filePath;
        _isDownloading = false;
      });

      debugPrint('widget.videoUrl: ${widget.videoUrl}');

      initPlayer();
    } catch (e) {
      debugPrint("Error downloading video: $e");
    }
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

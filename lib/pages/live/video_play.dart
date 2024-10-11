import 'package:flutter/material.dart';
import 'package:flutter_aliplayer/flutter_aliplayer.dart';
import 'package:flutter_aliplayer/flutter_aliplayer_factory.dart';

class VideoPlay extends StatefulWidget {
  final String videoUrl;
  const VideoPlay({super.key, required this.videoUrl});

  ///1、创建播放器
  // final FlutterAliplayer fAliplayer = FlutterAliPlayerFactory.createAliPlayer();

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  late FlutterAliplayer fAliplayer;

  @override
  void initState() {
    super.initState();
    fAliplayer = FlutterAliPlayerFactory.createAliPlayer();
    // widget.fAliplayer.setUrl(widget.videoUrl);

    // listenerPlayerState();
  }

  ///2、设置监听,只列举了部分接口，更多接口可以参考播放器 Android\iOS 接口文档
  void listenerPlayerState() {
    ///准备成功
    fAliplayer.setOnPrepared((playerId) {});

    ///首帧显示
    fAliplayer.setOnRenderingStart((playerId) {});

    ///视频宽高变化
    fAliplayer.setOnVideoSizeChanged(
        (int width, int height, int? rotation, String playerId) {
      debugPrint('$width,$height,$rotation,$playerId');
    });

    ///播放器状态变化
    fAliplayer.setOnStateChanged((newState, playerId) {});

    ///加载状态
    fAliplayer.setOnLoadingStatusListener(
        loadingBegin: (playerId) {},
        loadingProgress: (percent, netSpeed, playerId) {},
        loadingEnd: (playerId) {});

    ///拖动完成
    fAliplayer.setOnSeekComplete((playerId) {});

    ///播放器事件信息回调，包括 buffer、当前播放进度 等等信息，根据 infoCode 来判断，对应 FlutterAvpdef.infoCode
    fAliplayer.setOnInfo((infoCode, extraValue, extraMsg, playerId) {});

    ///播放完成
    fAliplayer.setOnCompletion((playerId) {});

    ///设置流准备完成
    fAliplayer.setOnTrackReady((playerId) {});

    ///截图结果
    fAliplayer.setOnSnapShot((path, playerId) {});

    ///错误结果
    fAliplayer.setOnError((errorCode, errorExtra, errorMsg, playerId) {});

    ///切换流变化
    fAliplayer.setOnTrackChanged((value, playerId) {});
  }

  // 4、设置播放源
  void onViewPlayerCreated(viewId) async {
    debugPrint('widget.videoUrl:${widget.videoUrl}');
    fAliplayer.setUrl(
        'https://shtest.cretechsh.cn/ac4e864a967d2dc6016495df98ae8bf4.mp4');
    // https://shtest.cretechsh.cn/ac4e864a967d2dc6016495df98ae8bf4.mp4
    // https://playback.cretech.cn/123996_VrTslAJv/index.m3u8
  }

  @override
  Widget build(BuildContext context) {
    ///3、设置渲染的 View
    var x = 0.0;
    var y = 0.0;
    Orientation orientation = MediaQuery.of(context).orientation;
    var width = MediaQuery.of(context).size.width;

    double height;
    if (orientation == Orientation.portrait) {
      height = width * 9.0 / 16.0;
    } else {
      height = MediaQuery.of(context).size.height;
    }
    AliPlayerView aliPlayerView = AliPlayerView(
        onCreated: onViewPlayerCreated,
        x: x,
        y: y,
        width: width,
        height: height);
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return Scaffold(
          body: Column(
            children: [
              Container(
                  color: Colors.black,
                  width: width,
                  height: height,
                  child: aliPlayerView),
            ],
          ),
        );
      },
    );
  }
}

///4、设置播放源
///说明：STS 播放方式，vid、region、accessKeyId、accessKeySecret、securityToken 为必填，其他参数可选
///     AUTH 播放方式，vid、region、playAuth 为必填，其他参数可选
/// 每个 Map 对应的key 在 flutter 的 Demo 的 config.dart 中查看，fAliplayer 为播放器对象，如果还未创建，参考后续文档创建播放器
void onViewPlayerCreated(viewId) async {
  // ///将 渲染 View 设置给播放器
  // fAliplayer.setPlayerView(viewId);
  // //设置播放源
  // FlutterAliplayer.createVidPlayerConfigGenerator();
  // // 设置预览时间
  // FlutterAliplayer.setPreviewTime(
  //     int.parse(_dataSourceMap[DataSourceRelated.PREVIEWTIME_KEY]));
  // String playConfig = await FlutterAliplayer.generatePlayerConfig();

  // switch (_playMode) {
  //   //URL 播放方式
  //   case ModeType.URL:
  // this.fAliplayer.setUrl(_dataSourceMap[DataSourceRelated.URL_KEY]);
  // break;
  //   //STS 播放方式
  //   case ModeType.STS:
  //     this.fAliplayer.setVidSts(
  //         vid: _dataSourceMap[DataSourceRelated.VID_KEY],
  //         region: _dataSourceMap[DataSourceRelated.REGION_KEY],
  //         accessKeyId: _dataSourceMap[DataSourceRelated.ACCESSKEYID_KEY],
  //         accessKeySecret:
  //             _dataSourceMap[DataSourceRelated.ACCESSKEYSECRET_KEY],
  //         securityToken: _dataSourceMap[DataSourceRelated.SECURITYTOKEN_KEY],
  //         definitionList: _dataSourceMap[DataSourceRelated.DEFINITION_LIST],
  //         playConfig: playConfig);
  //     break;
  //   //AUTH 播放方式
  //   case ModeType.AUTH:
  //     this.fAliplayer.setVidAuth(
  //         vid: _dataSourceMap[DataSourceRelated.VID_KEY],
  //         region: _dataSourceMap[DataSourceRelated.REGION_KEY],
  //         playAuth: _dataSourceMap[DataSourceRelated.PLAYAUTH_KEY],
  //         definitionList: _dataSourceMap[DataSourceRelated.DEFINITION_LIST],
  //         previewTime: _dataSourceMap[DataSourceRelated.PREVIEWTIME_KEY]);
  //     break;
  //   default:
  // }
}

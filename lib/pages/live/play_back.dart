import 'package:flutter/material.dart';

import 'package:microbook_library/http/network_service.dart';
import 'package:microbook_library/model/live_model.dart';
import 'package:microbook_library/widgets/live_list_item.dart';
import 'package:go_router/go_router.dart';

class PlayBack extends StatefulWidget {
  const PlayBack({super.key, required this.time});

  final String time;

  @override
  State<PlayBack> createState() => _PlayBackState();
}

class _PlayBackState extends State<PlayBack> {
  final NetworkService _networkService = NetworkService();
  late List<LiveModel> _dataList;

  @override
  void initState() {
    super.initState();
    _dataList = []; // 清空

    loadData();
  }

  // 请求接口
  Future loadData() async {
    try {
      const String url = '/livecloudm/js/hapi/Live.php?';

      Map<String, dynamic> param = {
        "flag": widget.time,
        'app_version': '1.0.0',
        'official': 1,
        'apptype': 3
      };
      final String paramString =
          param.entries.map((e) => '${e.key}=${e.value}').join('&');
      debugPrint('paramString:$paramString');
      final response =
          await _networkService.get(type: 0, endpoint: '$url$paramString');

      List<dynamic> data = response['data'] ?? [];
      List<LiveModel> list =
          data.map((json) => LiveModel.fromJson(json)).toList();
      debugPrint('mounted:$mounted, $response');
      if (mounted) {
        setState(() {
          _dataList.addAll(list);
        });
      }
    } catch (e) {
      debugPrint('e: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        color: Colors.blue,
        backgroundColor: Colors.amber,
        child: GestureDetector(
          child: ListView.builder(
            itemBuilder: (context, index) {
              LiveModel model = _dataList[index];
              return LiveListItem(
                schoolName: model.companyName,
                theme: model.theme,
                content: model.content,
                logo: model.logo,
                imgBigUrl: model.imgBigUrl,
                location: model.livelocation,
                time: model.livetime,
                status: model.status,
                replayURL: model.replayURL,
                onTap: () {
                  context.push('/live/videoPlay',
                      extra:
                          'https://iclasscloud.cretech.cn/livecloudm/lib/playvideo.html?play=${model.replayURL}');
                  // context.go('/live/videoPlay', extra: model.replayURL);
                },
              );
            },
            itemCount: _dataList.length,
          ),
          onTap: () {
            context.push('/live/videoPlay', extra: 'model.replayURL');
          },
        ),
        onRefresh: () async {
          debugPrint('刷新');
          _dataList = [];
          return loadData();
        });
  }
}

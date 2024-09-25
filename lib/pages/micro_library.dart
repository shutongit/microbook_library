import 'package:flutter/material.dart';

import 'package:microbook_library/http/network_service.dart';
import 'package:microbook_library/pages/live/video_play.dart';
import 'package:go_router/go_router.dart';

class MicroLibrary extends StatefulWidget {
  const MicroLibrary({super.key});

  @override
  State<MicroLibrary> createState() => _MicroLibraryState();
}

class _MicroLibraryState extends State<MicroLibrary> {
  late List dataArray; // 数据源
  final NetworkService _networkService = NetworkService();
  @override
  void initState() {
    super.initState();
    loadData();
  }

  /// 设置背景色和图片
  void _configItemInfo() {
    for (var i = 0; i < dataArray.length; i++) {
      Map item = dataArray[i];
      String name = item['gallery_name'] ?? '';
      if (name == '最新动态') {
        item['imgurl'] = 'assets/images/homeBBIcon/news.png';
        item['bgColor'] = const Color(0xFFDCF0FF);
      } else if (name == '我们的校园') {
        item['imgurl'] = 'assets/images/homeBBIcon/campusScenery.png';
        item['bgColor'] = const Color(0xFFE9F9E3);
      } else if (name == '荣誉墙') {
        item['imgurl'] = 'assets/images/homeBBIcon/honorwall.png';
        item['bgColor'] = const Color(0xFFFFEDED);
      } else if (name == '办学理念') {
        item['imgurl'] = 'assets/images/homeBBIcon/icon_bm02.png';
        item['bgColor'] = const Color(0xFFFFEDE5);
      } else if (name == '重大活动') {
        item['imgurl'] = 'assets/images/homeBBIcon/event.png';
        item['bgColor'] = const Color(0xFFEFF1FF);
      } else if (name == '学科建设') {
        item['imgurl'] = 'assets/images/homeBBIcon/projectSet.png';
        item['bgColor'] = const Color(0xFFE0FBFA);
      } else if (name == '年级成长') {
        item['imgurl'] = 'assets/images/homeBBIcon/student-select.png';
        item['bgColor'] = const Color.fromRGBO(239, 220, 255, 0.28);
        // item['bgColor'] = const Color(0xEFdcff48);
      } else if (name == '素质素养') {
        item['imgurl'] = 'assets/images/homeBBIcon/quality.png';
        item['bgColor'] = const Color.fromRGBO(238, 250, 214, 0.5);
        // item['bgColor'] = const Color(0xEEfad680);
      } else if (name == '成果荟萃') {
        item['imgurl'] = 'assets/images/homeBBIcon/achievements.png';
        item['bgColor'] = const Color.fromRGBO(255, 240, 220, 0.47);
        // item['bgColor'] = const Color(0xFFF0DC77);
      } else {
        item['imgurl'] = null;
        item['bgColor'] = const Color(0xFFDCF0FF);
      }
    }
  }

  /// 请求数据
  void loadData() async {
    dataArray = [];

    final res = await _networkService.post(
        type: 1,
        endpoint: '/gallery/api/v1/gallery/list',
        data: <String, dynamic>{"school_id": "10C516", "count": 0, "page": 1});
    setState(() {});
    List arr = res['galleries'] ?? [];
    dataArray = arr.isNotEmpty ? res['galleries'] : [];
    _configItemInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFefefef)),
      child: dataArray.isNotEmpty
          ? Container(
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                child: GridView.builder(
                  itemCount: dataArray.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        context.push('/micro/list');

                        ///${dataArray[index]['gallery_id']}
                        // context.go(Uri(
                        //     path:
                        //         'micro/list/${dataArray[index]['gallery_id']}',
                        //     queryParameters: {
                        //       'filter': dataArray[index]['gallery_name']
                        //     }).toString());
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: dataArray[index]['bgColor'],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          dataArray[index]['imgurl']?.isNotEmpty ?? false
                              ? Positioned(
                                  bottom: 10,
                                  right: 10,
                                  width: 40,
                                  height: 40,
                                  child: Image.asset(
                                    dataArray[index]['imgurl'] ??
                                        'assets/images/homeBBIcon/achievements.png',
                                    width: 20,
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              '${dataArray[index]['gallery_name']}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ))
          : Center(
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/black.png',
                      height: 60,
                    ),
                    const Text('未选择学校，请先'),
                    TextButton(onPressed: () {}, child: const Text('选择学校')),
                  ],
                ),
              ),
            ),
    );
  }
}

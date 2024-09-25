import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:microbook_library/base/page.dart';
import 'package:go_router/go_router.dart';
import 'package:microbook_library/http/network_service.dart';
import 'package:microbook_library/model/live_model.dart';
import 'package:microbook_library/widgets/micro/live_item.dart';

class MicroList extends BasePage {
  final String? id;
  const MicroList(this.id, {super.key});

  @override
  State<MicroList> createState() => _MicroListState();
}

class _MicroListState extends BasePageState<MicroList> {
  final NetworkService _networkService = NetworkService();
  List<LiveModel> liveList = []; // 直播列表

  @override
  void initState() {
    super.initState();
    title = '微册馆';
    isShowBackPress = true;
    setCustomBackPress(IconButton(
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          }
        },
        icon: const Icon(Icons.baby_changing_station)));

    loadLiveList();
    loadMicroList();
  }

  List<Widget> playWidget() {
    List<Widget> list = [];
    for (var i = 0; i < liveList.length; i++) {
      LiveModel model = liveList[i];
      list.add(Text('logo:${model.logo}'));
    }
    return list;
  }

  @override
  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Swiper(
        itemBuilder: (context, index) {
          return LiveItem(model: liveList[index]);
        },
        itemCount: liveList.length,
        autoplay: false,
        loop: false,
        scrollDirection: Axis.horizontal,
        viewportFraction: 0.7,
        scale: 0.9,
        curve: Curves.bounceIn,
        onIndexChanged: (value) {
          log('value:$value');
        },
      ),
    );
  }

  // 请求直播列表
  void loadLiveList() async {
    const param = {
      'company_id': '10306',
      'p': 1,
      'app_version': '1.0.0',
      'official': 1,
      'apptype': 3
    };
    const String url = '/livecloudm/js/hapi/getNewH5Lists.php?';

    final paramString =
        param.entries.map((e) => '${e.key}=${e.value}').join('&');

    final res =
        await _networkService.get(type: 0, endpoint: '$url$paramString');
    List live = res['data']['live'] ?? [];
    List<LiveModel> list = live.map((json) {
      return LiveModel.fromJson(json);
    }).toList();
    setState(() {
      liveList.addAll(list);
    });
  }

  // 请求微册列表
  void loadMicroList() async {
    Map<String, dynamic> param = {"count": 10, "page": 1, "school_id": "10306"};
    final res = await _networkService.post(
        type: 1,
        endpoint: '/gallery/api/v1/micro_book/list_dynamic',
        data: param);
    log('res: $res');
  }
}

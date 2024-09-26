import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:microbook_library/base/page.dart';
import 'package:go_router/go_router.dart';
import 'package:microbook_library/http/network_service.dart';
import 'package:microbook_library/model/live_model.dart';
import 'package:microbook_library/model/micro_model.dart';
import 'package:microbook_library/widgets/micro/live_item.dart';
import 'package:microbook_library/widgets/micro/micro_item.dart';

class MicroList extends BasePage {
  final String? id;
  const MicroList(this.id, {super.key});

  @override
  State<MicroList> createState() => _MicroListState();
}

class _MicroListState extends BasePageState<MicroList> {
  final NetworkService _networkService = NetworkService();
  final _swiperController = SwiperController();
  List<LiveModel> liveList = []; // 直播列表
  List<MicroModel> microList = []; // 微册列表
  int page = 1; // 当前页码
  bool noMoreData = false; // 是否还有更多数据
  int allCount = 0;

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

    loadAllData();
  }

  @override
  Widget buildBody() {
    return Swiper(
      itemBuilder: (context, index) {
        return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          // 根据组件大小来设置子组件的大小
          return Center(
            child: SizedBox(
              width: constraints.biggest.width,
              height: constraints.biggest.width * 343 / 244,
              child: index < liveList.length
                  ? LiveItem(model: liveList[index])
                  : MicroItem(model: microList[index - liveList.length]),
            ),
          );
        });
      },
      itemCount: allCount,
      autoplay: false,
      loop: false,
      scrollDirection: Axis.horizontal,
      viewportFraction: 0.7,
      scale: 0.9,
      curve: Curves.bounceIn,
      controller: _swiperController,
      onIndexChanged: (value) {
        log('va: $value');
        log('allCount$allCount');
        if (value == (allCount - 2)) {
          log('loading');
          page++;
          loadMicroList();
        }
      },
    );
  }

  // 请求直播列表和微册列表
  void loadAllData() async {
    showLoading();
    await Future.wait([requestLiveList(), requestMicroList()]).then((values) {
      setState(() {
        liveList.addAll(values[0] as List<LiveModel>);
        microList.addAll(values[1] as List<MicroModel>);
        allCount = microList.length + liveList.length;
      });
    }).whenComplete(() {
      hideLoading();
    });
  }

  /// 请求微册
  void loadMicroList() async {
    List<MicroModel> list = await requestMicroList();
    setState(() {
      microList.addAll(list);
      log('microList: ${microList.length}');
      allCount += list.length;
    });
  }

  // 请求直播列表
  Future<List<LiveModel>> requestLiveList() async {
    const param = {
      'company_id': '50672',
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

    return list;
  }

  // 请求微册列表
  Future<List<MicroModel>> requestMicroList() async {
    Map<String, dynamic> param = {
      "count": 10,
      "page": page,
      "school_id": "10306"
    };
    final res = await _networkService.post(
        type: 1,
        endpoint: '/gallery/api/v1/micro_book/list_dynamic',
        data: param);
    List micro = res['micro_books'] ?? [];
    log('res:$res');
    log('page: $page');
    List<MicroModel> list = micro.map((json) {
      return MicroModel.fromJson(json);
    }).toList();

    return list;
  }
}

import 'package:flutter/material.dart';
import 'package:microbook_library/http/network_service.dart';
import 'package:microbook_library/model/live_model.dart';
import 'package:microbook_library/widgets/live_list_item.dart';

class Live extends StatefulWidget {
  const Live({super.key});

  @override
  State<Live> createState() => _LiveState();
}

class _LiveState extends State<Live> {
  // 网络请求对象
  final NetworkService _networkService = NetworkService();

  // 数据源
  late Future<List<LiveModel>> _listData;

  @override
  void initState() {
    super.initState();

    _listData = fetchLiveData();
  }

  /// 获取年月日
  String getCurrentDate() {
    final DateTime now = DateTime.now();
    return '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
  }

  /// 请求直播列表
  Future<List<LiveModel>> fetchLiveData() async {
    // try {
    Map<String, dynamic> param = {
      "flag": getCurrentDate(),
      "app_version": "1.0.0",
      "official": 1,
      "apptype": 3,
    };
    const String url = '/livecloudm/js/hapi/Live.php?';

    final paramString =
        param.entries.map((e) => '${e.key}=${e.value}').join('&');

    final response = await _networkService.get('$url$paramString');

    // List<dynamic> data = response['data'] as List<dynamic>;
    List<dynamic> data = response['data'] ?? [];
    List<LiveModel> list =
        data.map((json) => LiveModel.fromJson(json)).toList();

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _listData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            debugPrint('${snapshot.error}');
            return Center(
              child: Text('加载直播列表时出错：${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('没有直播'),
            );
          } else {
            return ListView.builder(
              itemBuilder: (content, index) {
                LiveModel model = snapshot.data![index];
                return LiveListItem(
                    schoolName: model.companyName,
                    theme: model.theme,
                    content: model.content,
                    logo: model.logo,
                    location: model.livelocation,
                    time: model.livetime,
                    status: model.status);
              },
              itemCount: snapshot.data!.length,
            );
          }
        });
  }
}

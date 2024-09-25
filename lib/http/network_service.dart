import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkService {
  // 私有构造函数
  NetworkService._internal();

// 保存单利实例
  static final NetworkService _instance = NetworkService._internal();

// 公共工厂构造函数，用户访问单利实例
  factory NetworkService() {
    return _instance;
  }

  static const String baseUrl = 'https://iclasscloud.cretech.cn';
  static const String p1BaseUrl = 'https://p1.cretechsh.cn';

  // NetworkService({required this.baseUrl});
  String getRequestHeadUrl(type) {
    String url = '';
    if (type == 0) {
      url = baseUrl;
    } else {
      url = p1BaseUrl;
    }
    return url;
  }

  /// get请求
  /// type: 基础接口类型
  /// endpoint: 接口地址参数
  Future<dynamic> get({int type = 0, String endpoint = ''}) async {
    final response =
        await http.get(Uri.parse('${getRequestHeadUrl(type)}$endpoint'));

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load data');
    }
  }

  /// post请求
  Future<dynamic> post(
      {int type = 0, String endpoint = '', Map<String, dynamic>? data}) async {
    final response = await http.post(
        Uri.parse('${getRequestHeadUrl(type)}$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to post data');
    }
  }
}

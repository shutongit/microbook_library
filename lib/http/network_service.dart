import 'dart:convert';
import 'package:flutter/material.dart';
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

  // NetworkService({required this.baseUrl});

  /// get请求
  Future<dynamic> get(String endpoint) async {
    debugPrint('请求域名url:$baseUrl$endpoint');

    final response = await http.get(Uri.parse('$baseUrl$endpoint'));

    if (response.statusCode == 200) {
      debugPrint('请求结果response: ${utf8.decode(response.bodyBytes)}');
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load data');
    }
  }

  /// post请求
  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to post data');
    }
  }
}

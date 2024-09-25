import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({super.key});
}

abstract class BasePageState<T extends BasePage> extends State<T> {
  String? title; // 标题
  bool isLoading = false; // 是否显示loading
  bool isShowBackPress = false; // 是否显示返回按钮
  Widget? customBackWidget; // 是否自定义返回按钮

// 用户统一导航栏样式
  PreferredSizeWidget buildAppBar(String title) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.blue[400],
      foregroundColor: Colors.white,
      leading: isShowBackPress
          ? customBackWidget ??
              IconButton(
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    }
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded))
          : null,
      actions: [
        IconButton(
            onPressed: () {
              log('统一导航栏事件');
            },
            icon: const Icon(Icons.settings))
      ],
    );
  }

  // 用户统一的加载效果
  Widget buildLoading() {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container();
  }

  /// 用户统一的页面主体样式
  Widget buildBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title ?? ''),
      body: Stack(
        children: [buildBody(), buildLoading()],
      ),
    );
  }

  // 可选的加载控制方法
  // 显示加载
  void showLoading() {
    setState(() {
      isLoading = true;
    });
  }

  // 隐藏加载
  void hideLoading() {
    setState(() {
      isLoading = false;
    });
  }

  // 自定义返回事件
  void setCustomBackPress(Widget? widget) {
    if (widget != null) {
      setState(() {
        customBackWidget = widget;
      });
    }
  }

  /// log打印
  void log(String? string) {
    debugPrint(string);
  }
}

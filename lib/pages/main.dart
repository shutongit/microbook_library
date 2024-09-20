import 'package:flutter/material.dart';
import 'package:microbook_library/pages/about.dart';
import 'package:microbook_library/pages/live/page.dart';
import 'package:microbook_library/pages/micro_library.dart';
import 'package:microbook_library/pages/school_rank.dart';
import 'package:microbook_library/pages/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static List<Map> pages = [
    // Live(),
    {'widget': const LivePage(), 'load': false},
    {'widget': const MicroLibrary(), 'load': false},
    {'widget': const SchoolRank(), 'load': false},
    {'widget': const ThemePage(), 'load': false},
    {'widget': const About(), 'load': false},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _getAppBarTitleWidget(_selectedIndex),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        foregroundColor: Colors.white,
        actions: _selectedIndex == 0
            ? null
            : [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // 在这里添加搜索功能
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    // 在这里添加通知功能
                  },
                ),
              ],
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: IndexedStack(
          index: _selectedIndex,
          children: List.generate(pages.length, (index) {
            pages[index]['load'] =
                pages[index]['load'] || _selectedIndex == index; // 记录是否加载过
            debugPrint('pages${pages[index]}');

            /// 根据是否已经加载过，来确定是否显示加载
            return Offstage(
              offstage: !pages[index]['load'],
              child: pages[index]['load']
                  ? pages[index]['widget']
                  : const SizedBox.shrink(),
            );
          }),
        ),
      ),

      // 直播 微册馆 学校榜 主题 关于
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12.0,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: '直播'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: '微册馆'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: '学校榜'),
          BottomNavigationBarItem(icon: Icon(Icons.color_lens), label: '主题'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: '关于'),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  /// 获取页面标题
  /// @param index 下标
  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return '直播';
      case 1:
        return '微册馆';
      case 2:
        return '学校榜';
      case 3:
        return '主题';
      case 4:
        return '关于';

      default:
        return '微册馆';
    }
  }

  /// 获取导航栏的视图
  Widget _getAppBarTitleWidget(int index) {
    if (index == 0) {
      return Row(children: [
        const Expanded(
            child: TextField(
          decoration: InputDecoration(
              hintText: '请输入内容',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white70)),
        )),
        const SizedBox(
          width: 5,
        ),
        TextButton(
          onPressed: () {},
          // style: TextButton.styleFrom(foregroundColor: Colors.white),
          style: const ButtonStyle(
            foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
          ),
          child: const Text('搜索'),
        )
      ]);
    } else {
      return Text(_getAppBarTitle(index));
    }
  }
}

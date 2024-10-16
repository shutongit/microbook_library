import 'package:flutter/material.dart';
import 'package:microbook_library/pages/live/live.dart';
import 'package:microbook_library/pages/live/play_back.dart';

enum Day { zero, one, two, three, four, five, six }

class LivePage extends StatefulWidget {
  const LivePage({super.key});

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  late PageController _pageViewController;

  /// 当前选中的页面下标
  int _currentPageIndex = 0;

  /// 时间内容数组
  List dateList = getDates();

  /// 颜色内容数组
  List colorList = [
    const Color.fromRGBO(25, 67, 171, 1),
    const Color.fromRGBO(250, 147, 37, 1),
    const Color.fromRGBO(176, 189, 205, 1),
    const Color.fromRGBO(253, 83, 86, 1),
    const Color.fromRGBO(255, 0, 102, 1),
    const Color.fromRGBO(140, 198, 62, 1),
    const Color.fromRGBO(235, 3, 13, 1),
  ];

  @override
  void initState() {
    super.initState();

    _pageViewController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: colorList[_currentPageIndex],
            width: 1,
          ))),
          height: 35,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      _currentPageIndex = index;
                      _pageViewController.animateToPage(_currentPageIndex,
                          duration: const Duration(microseconds: 400),
                          curve: Curves.easeInOut);
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: _currentPageIndex == index
                          ? colorList[index]
                          : Colors.transparent,
                      border: Border(
                          right: BorderSide(
                              color: _currentPageIndex == index
                                  ? colorList[index]
                                  : Colors.grey,
                              width: 1.0),
                          top: BorderSide(
                              color: _currentPageIndex == index
                                  ? colorList[index]
                                  : Colors.grey,
                              width: 1.0))),
                  child: Center(
                    widthFactor: 1.2,
                    child: Text(
                      '${index == 0 ? '今日直播' : dateList[index]['label']}',
                      style: TextStyle(
                        color: _currentPageIndex == index
                            ? Colors.white
                            : Colors.black,
                        fontSize: _currentPageIndex == index ? 13 : 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
            itemCount: dateList.length,
          ),
        ),
        Expanded(
          child: PageView(
            controller: _pageViewController,
            onPageChanged: (value) {
              setState(() {
                _currentPageIndex = value;
              });
            },
            children: [
              // LazyController(
              //   builder: (context) {
              //     return const Live();
              //   },
              // ),
              const Live(),
              PlayBack(
                time: dateList[1]['value'] ?? '',
              ),
              PlayBack(
                time: dateList[2]['value'] ?? '',
              ),
              PlayBack(
                time: dateList[3]['value'] ?? '',
              ),
              PlayBack(
                time: dateList[4]['value'] ?? '',
              ),
              PlayBack(
                time: dateList[5]['value'] ?? '',
              ),
              PlayBack(
                time: dateList[6]['value'] ?? '',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 获取今天及之后的6天日期
List<Map> getDates() {
  DateTime now = DateTime.now();
  List<Map> dates = [];

  for (int i = 0; i < 7; i++) {
    DateTime time = now.subtract(Duration(days: i));
    String timeString =
        '${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}';
    dates.add({
      'value':
          '${time.year}${time.month >= 10 ? time.month : '0${time.month}'}${time.day >= 10 ? time.day : '0${time.day}'}',
      "label": timeString
    });
  }
  debugPrint('dates: $dates');
  return dates;
}

class LazyController {
  final Widget Function(BuildContext context) builder;

  LazyController({required this.builder});
}

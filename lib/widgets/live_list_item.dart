import 'package:flutter/material.dart';
import 'dart:math';

class LiveListItem extends StatefulWidget {
  const LiveListItem(
      {super.key,
      required this.schoolName,
      required this.theme,
      required this.content,
      required this.logo,
      required this.location,
      required this.time,
      required this.status});

  final String schoolName;
  final String theme;
  final String content;
  final String logo;
  final String location;
  final int time;
  final String status;

  @override
  State<LiveListItem> createState() => _LiveListItemState();
}

class _LiveListItemState extends State<LiveListItem> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: RowContainer(widget: widget),
    );
  }
}

/// 行布局
class RowContainer extends StatelessWidget {
  const RowContainer({
    super.key,
    required this.widget,
  });

  final LiveListItem widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors.black45,
                  width: 0.5,
                  style: BorderStyle.solid))),
      padding: const EdgeInsets.all(5),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 学校logo
          LeftInfo(widget: widget),
          // 中间文字内容
          CenterInfo(widget: widget),
          // 右侧状态和时间
          RightInfo(widget: widget),
        ],
      ),
    );
  }
}

/// 左侧信息
class LeftInfo extends StatelessWidget {
  const LeftInfo({
    super.key,
    required this.widget,
  });

  final LiveListItem widget;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.logo,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
    );
  }
}

/// 右侧信息
class RightInfo extends StatelessWidget {
  const RightInfo({
    super.key,
    required this.widget,
  });

  final LiveListItem widget;

  @override
  Widget build(BuildContext context) {
    // debugPrint('widget: $widget');
    Map statusMap = configStatus(widget.status);
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(width: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),

          /// 状态视图
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
                color: statusMap['color'],
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(5),
            child: Text(
              statusMap['text'],
              style: const TextStyle(color: Colors.white, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),

          /// 时间
          Row(
            children: [
              Image.asset(
                'assets/images/bell.png',
                width: 15,
                fit: BoxFit.contain,
              ),
              Text(
                millisecondToHourSecond(widget.time),
                style: const TextStyle(fontSize: 12, color: Colors.red),
              ),
            ],
          )
        ],
      ),
    );
  }
}

/// 中间文本信息
class CenterInfo extends StatelessWidget {
  const CenterInfo({
    super.key,
    required this.widget,
  });

  final LiveListItem widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/hand_away.png',
                  width: 20,
                  fit: BoxFit.contain,
                ),
                Text(
                  widget.schoolName,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue[900],
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.theme,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(widget.content),
            Text(
              widget.location,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

/// 将毫秒转换为时分
String millisecondToHourSecond(int duration) {
  String time = '';

  int hour = (duration / (60 * 60)).ceil();

  int second = (duration % (60 * 60)) ~/ 60;

  time =
      '${hour > 12 ? '下午' : '上午'}${hour < 10 ? '0$hour' : hour}:${second < 10 ? '0$second' : second}';
  return time;
}

/// 配置状态的颜色和文字
Map<String, dynamic> configStatus(String status) {
  Color color = Colors.grey;
  String text = '直播结束';
  if (status == '正在直播') {
    color = Colors.green;
    text = '正在直播';
  } else if (status == '尚未开始') {
    color = Colors.orange;
    text = '尚未开始';
  } else if (status == '直播已结束') {
    color = Colors.red;
    text = '直播结束';
  } else {
    color = Colors.grey;
    text = '未知状态';
  }

  return {
    "color": color,
    "text": text,
  };
}

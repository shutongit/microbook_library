import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:microbook_library/model/live_model.dart';

class LiveItem extends StatelessWidget {
  final LiveModel model;
  const LiveItem({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 192, 232, 255),
            Color.fromARGB(255, 133, 211, 255)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              CachedNetworkImage(
                width: 200,
                height: 115,
                imageUrl: model.logo,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.home_filled,
                    color: Color.fromARGB(255, 40, 101, 162),
                  ),
                  Text(
                    model.companyName,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 40, 101, 162)),
                  )
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    model.theme,
                    maxLines: 3,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 14),
                  )),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Text(
                  model.content,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
              const SizedBox(height: 10),
              Row(children: [
                Text(
                  model.companyLocation,
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  '上午${millisecondToHourSecond(model.livetime)}',
                  style: const TextStyle(fontSize: 12),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
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
}

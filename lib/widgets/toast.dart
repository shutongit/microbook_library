import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Toast {
  // final BuildContext context;
  // final String title;
  // final Duration? duration;
  // const Toast(this.context, this.title,
  //     {this.duration = const Duration(seconds: 2)});

  static final Toast _instance = Toast._internal();
  Toast._internal();
  factory Toast() => _instance;

  showToast(BuildContext context, String title,
      {Duration duration = const Duration(seconds: 2)}) {
    // return Builder(builder: (BuildContext context) {
    //   return const Text('123');
    // });
    toastification.show(
      context: context,
      autoCloseDuration: duration,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      showProgressBar: false,
      showIcon: false,
      closeButtonShowType: CloseButtonShowType.none,
      alignment: Alignment.bottomCenter,
      backgroundColor: const Color(0xef000000),
    );
  }
}

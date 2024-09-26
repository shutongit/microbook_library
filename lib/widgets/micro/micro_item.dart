import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:microbook_library/model/micro_model.dart';

class MicroItem extends StatelessWidget {
  final MicroModel model;
  const MicroItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: model.micro_book_cover.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: model.micro_book_cover,
              fit: BoxFit.contain,
            )
          : const Text('暂无封面'),
    );
  }
}

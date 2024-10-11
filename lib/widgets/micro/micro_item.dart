import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:microbook_library/model/micro_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:microbook_library/pages/micro/micro_list_bloc.dart';

class MicroItem extends StatelessWidget {
  final MicroModel model;
  // final Function(MicroModel)? showDetail;
  const MicroItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: model.micro_book_cover != null
          ? CachedNetworkImage(
              imageUrl: model.micro_book_cover ?? '',
              fit: BoxFit.contain,
            )
          : const Text('暂无封面'),
      onTap: () {
        // print('dianji ');
        // if (showDetail != null) {
        //   showDetail!(model);
        // }

        context.read<MicroListBloc>().showMicroDetail(model);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver.dart';
import 'package:flutter/src/rendering/sliver_grid.dart';

class MicroLibrary extends StatefulWidget {
  const MicroLibrary({super.key});

  @override
  State<MicroLibrary> createState() => _MicroLibraryState();
}

class _MicroLibraryState extends State<MicroLibrary> {
  late List dataArray; // 数据源
  @override
  void initState() {
    super.initState();
    loadData();
  }

  /// 请求数据
  void loadData() {
    dataArray = [];
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        // mainAxisSpacing: 10.0,
        // crossAxisSpacing: 10.0,
        // childAspectRatio: 4.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            color: Colors.teal[100 * (index % 9)],
            child: Text('grid item $index'),
          );
        },
        childCount: 20,
      ),
    );
    // return GridView.builder(
    //   itemCount: dataArray.length,
    //   gridDelegate:
    //       const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    //   itemBuilder: (BuildContext context, int index) {
    //     return const InkWell(
    //       child: GridTile(child: Text('data')),
    //     );
    //   },
    // );
  }
}

/// 自定义
// class CustomGridDelegate extends SliverGridDelegate {
//   final double dimension;

//   CustomGridDelegate({required this.dimension});

//   @override
//   SliverGridLayout getLayout(SliverConstraints constraints) {
//     int count = constraints.crossAxisExtent ~/ dimension;

//     // return Cutomg
//   }

//   @override
//   bool shouldRelayout(covariant SliverGridDelegate oldDelegate) {
//     // TODO: implement shouldRelayout
//     throw UnimplementedError();
//   }
// }
